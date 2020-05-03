class Seeds::ReportCollection
  def initialize(project: Project.last, created_at: Time.now)
    @project = project
    @created_at = created_at
  end

  def save!
    import_form.attributes = {
      commit_sha1: (0..32).map { (65 + rand(26)).chr }.join.downcase,
      head_branch: 'seed/branch',
      reports: reports
    }

    import_form.report_collection.created_at = @created_at
    import_form.report_collection.reports.each do |report|
      report.created_at = @created_at
    end

    import_form.save
  end

  private

  def reports
    [
      Seeds::Report::Memory.new.to_h,
      Seeds::Report::DatabaseRequest.new.to_h,
      Seeds::Report::RequestTime.new.to_h,
    ]
  end

  def import_form
    @import_form ||= ::ReportCollection::CreateForm.new(project: @project)
  end
end
