class Project::ReanalyseRecentReportCollectionsJob < ApplicationJob
  queue_as :default

  def perform(project)
    recent_uniq_branch_report_collections_for_project(project).each do |report_collection|
      ReportCollection::AnalyseJob.perform_later(report_collection)
    end
  end

  private

  def recent_uniq_branch_report_collections_for_project(project)
    report_collection_ids = project.report_collections.newest.analysed.limit(10).select(:id, :branch).uniq(&:branch).collect(&:id)
    report_collection_ids << project.lastest_report_collection.id
    report_collection_ids.uniq!

    project.report_collections.where(id: report_collection_ids)
  end
end
