class ReportCollection::AnalyseJob < ApplicationJob
  queue_as :default

  def perform(report_collection)
    @report_collection = report_collection

    analyse_reports!

    # Now broadcast updates
    ProjectChannel.broadcast_to(@report_collection.project, {
      body: ApplicationController.render(@report_collection.project.decorate)
    })

    # Update github check suite
    update_github_check_suite!
  end

  private

  def analyse_reports!
    @report_collection.reports.collect(&:analyse!)
    @report_collection.conclusion!
    @report_collection.last_analysed_at!
    @report_collection.project.last_analysed_at!
  end

  def update_github_check_suite!
    return unless @report_collection.github_check_suite?

    @report_collection.github_check_suite.update(conclusion: @report_collection.conclusion, status: :completed)

    # Also update GitHub
    install_service.create_status(@report_collection.project.full_name, @report_collection.github_check_suite.head_sha, @report_collection.conclusion, {
      context: 'PigCI',
      description: @report_collection.github_check_suite.description,
      target_url: Rails.application.routes.url_helpers.project_report_collection_url(@report_collection.project, @report_collection)
    })
  end

  def install_service
    @install_service ||= InstallService.new(@report_collection.project.install)
  end
end
