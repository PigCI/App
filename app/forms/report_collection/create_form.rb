class ReportCollection::CreateForm < ApplicationForm
  extend ModelAttribute

  attribute :library, :string
  attribute :library_version, :string
  attribute :commit_sha1, :string
  attribute :head_branch, :string

  attr_accessor :project
  attr_accessor :reports

  validates :commit_sha1, presence: true
  validates :head_branch, presence: true
  validates :project, presence: true
  validates :reports, presence: true
  validate :validate_json_schema, on: :schema_validation

  def reports=(value)
    @reports = value
  end

  def report_collection
    @report_collection ||= project.report_collections.find_or_create_by(
      commit_sha1: commit_sha1,
      branch: head_branch
    )
  end

  private

  def persist!
    saved = report_collection.persisted?

    report_collection.reports += @reports.collect do |report_params|
      report_collection.reports.new(report_params)
    end
    report_collection.reports.collect(&:save!) if saved

    return false unless saved

    ReportCollection::AnalyseJob.perform_later(report_collection.reload)
    saved
  end

  def json_attributes
    {
      library: library,
      library_version: library_version,
      commit_sha1: commit_sha1,
      head_branch: head_branch,
      reports: @reports
    }
  end

  def validate_json_schema
    schema_path = "#{Dir.pwd}/public/api/v1/reports/schema.json"
    json_errors = JSON::Validator.fully_validate(schema_path, json_attributes.to_json, strict: false) 

    return if json_errors.empty?

    errors.add(:base, json_errors)
  end
end
