class Api::V1::ReportsController < ActionController::API
  before_action :set_report, only: [:create]

  def create
    @report_form.attributes = report_form_params

    if @report_form.valid?(:schema_validation) && @report_form.save
      head :ok
    else
      render json: @report_form.errors, status: :unprocessable_entity
    end
  end

  private

  def render_api_key_unauthorized!
    render json: {
      error: 'API Key is invalid'
    }, status: :unauthorized
  end

  def set_report
    @project = Project.find_by!(api_key: request.headers.env['HTTP_X_APIKEY'])
    @report_form = ReportCollection::CreateForm.new(project: @project)

  rescue ActiveRecord::RecordNotFound
    render_api_key_unauthorized!
  end

  def report_form_params
    @report_form_params ||= params.permit(
      :library,
      :library_version,
      :commit_sha1,
      :head_branch,
      :reporter_name,
      reports: [
        :profiler, data: %i[
          key max min mean total number_of_requests max_change_percentage
        ]
      ]
    )
  end
end
