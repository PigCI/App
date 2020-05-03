class ProjectsController < AuthenticatedController
  before_action :set_project, only: %i[show edit setup update delete destroy]

  # GET /projects
  def index
    @projects = current_user.projects
    @github_repositories = current_user.github_repositories.where(project: nil).order(full_name: :asc)
  end

  # GET /projects/1
  def show
    set_meta_tags title: t('.title', project: @project, scope: ['meta_tags'])

    respond_to do |format|
      format.html do
        @report_collections = @project.report_collections.includes(:reports).newest.page(page_param)
      end
      format.json do
        @report_collections = @project.report_collections.newest.analysed.includes(:reports).page(page_param)
      end
    end
  end

  def setup
    set_meta_tags title: t('.title', project: @project, scope: ['meta_tags'])
  end

  # GET /projects/new
  def new
    @project = Project.new(install: current_user.installs.first)
  end

  # GET /projects/1/edit
  def edit
    set_meta_tags title: t('.title', project: @project, scope: ['meta_tags'])
  end

  # POST /projects
  def create
    @github_repository = current_user.github_repositories.find(params[:github_repository_id])

    @project = Project.new
    @project.attributes = {
      install: @github_repository.install,
      name: @github_repository.name,
      full_name: @github_repository.full_name,
      private: @github_repository.private,
      default_branch: @github_repository.default_branch
    }
    @github_repository.project = @project

    respond_to do |format|
      if @project.save && @github_repository.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        redirect_to new_project_path, alert: 'Unable to setup project'
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    respond_to do |format|
      if @project.update(project_params)
        Project::ReanalyseRecentReportCollectionsJob.perform_later(@project) if @project.pr_limits_changed?

        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete
    set_meta_tags title: t('.title', project: @project, scope: ['meta_tags'])
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = current_user.projects.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(
      :default_branch,
      :memory_max,
      :database_request_max,
      :request_time_max
    )
  end

  helper_method :page_param
  def page_param
    @page_param ||= params[:page] || 1
  end
end
