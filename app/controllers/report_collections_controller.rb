class ReportCollectionsController < AuthenticatedController
  before_action :set_report_collection_and_parents, only: [:show]

  # GET /reports/1
  # GET /reports/1.json
  def show
    @render_unhappy_pig_logo = @report_collection.conclusion_failure?

    set_meta_tags title: t('.title', report_collection: @report_collection, project: @project, scope: ['meta_tags'])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report_collection_and_parents
    @report_collection = current_user.projects.find(params[:project_id]).report_collections.find(params[:id]).decorate
    @project = @report_collection.project
  end
end
