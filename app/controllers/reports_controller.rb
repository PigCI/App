class ReportsController < AuthenticatedController
  before_action :set_report_and_parents, only: [:show]

  # GET /reports/1
  # GET /reports/1.json
  def show
    @render_unhappy_pig_logo = @report.conclusion_failure?

    set_meta_tags title: t('.title', report: @report, report_collection: @report_collection, project: @project, scope: ['meta_tags'])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report_and_parents
    @project = current_user.projects.find(params[:project_id])
    @report_collection = @project.report_collections.find(params[:report_collection_id]).decorate
    @report = @report_collection.reports.find(params[:id]).decorate
  end
end
