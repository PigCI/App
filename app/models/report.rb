class Report < ApplicationRecord
  extend FriendlyId
  friendly_id :profiler, use: %i[finders slugged history scoped], scope: :report_collection_id

  belongs_to :report_collection
  belongs_to :project

  has_one_attached :raw_data

  enum profiler: {
    memory: 'memory',
    database_request: 'database_request',
    request_time: 'request_time'
  }
  enum conclusion: GithubCheckSuite.conclusions, _prefix: :conclusion

  validates :profiler, presence: true
  validates :raw_data, presence: true
  validates :branch, presence: true
  # validates :max, presence: true
  # validates :max_difference_from_default_branch, presence: true
  # validates :min, presence: true
  # validates :min_difference_from_default_branch, presence: true
  # validates :total_requests, presence: true

  scope :analysed, -> { where.not(analysed_at: nil) }
  scope :with_profiler, ->(profiler) { where(profiler: profiler) }
  scope :by_profiler_name, -> { order(profiler: :asc) }
  scope :created_before, ->(time) { analysed.where(created_at: [Time.at(0)..time]).newest }
  scope :max_value_for_collection_by_profiler, -> { sort_by(&:sort_by_max).uniq(&:profiler).sort_by(&:profiler) }

  before_validation do
    self.project = report_collection.project
    self.branch = report_collection.branch
  end

  def to_s
    Report.human_enum_name(:profiler, profiler)
  end

  def sort_by_max
    -max
  end

  def data=(value)
    @data = value
    raw_data.attach(io: StringIO.new(value.to_json), filename: "#{profiler}.json", content_type: 'application/json')
  end

  def data
    @data ||= JSON.parse(raw_data.blob.download, symbolize_names: true).sort_by do |row|
      BigDecimal(row[:max]) * -1
    end.collect do |row|
      row[:difference] = BigDecimal(row[:max]) - BigDecimal(row[:min])
      row
    end
  end

  def analyse!
    self.attributes = {
      max: data.collect { |row| BigDecimal(row[:max]) }.max,
      min: data.collect { |row| BigDecimal(row[:min]) }.min,
      total_requests: data.collect { |row| row[:number_of_requests].to_i }.inject(0, :+)
    }

    self.max_difference_from_default_branch = calc_max_difference_from_default_branch
    self.min_difference_from_default_branch = calc_min_difference_from_default_branch

    self.conclusion = calc_conclusion

    self.analysed_at = current_time_from_proper_timezone
    save!
  end

  def calc_conclusion
    return 'neutral' unless profiler.in?(%w[memory database_request request_time])

    if (max / unit_scaling_modifier) >= project.send("#{profiler}_max")
      'failure'
    elsif max_difference_from_default_branch >= BigDecimal(0)
      'neutral'
    else
      'success'
    end
  end

  def calc_max_difference_from_default_branch
    previous_max = previous_report_from_default_branch&.max || 0
    difference_from_default = BigDecimal(max) / BigDecimal(previous_max || max)

    return BigDecimal(0) if difference_from_default.zero? || !difference_from_default.finite?

    (difference_from_default * BigDecimal(100)) - BigDecimal(100)
  end

  def calc_min_difference_from_default_branch
    previous_min = previous_report_from_default_branch&.min || 0
    difference_from_default = BigDecimal(min) / BigDecimal(previous_min || min)

    return BigDecimal(0) if difference_from_default.zero? || !difference_from_default.finite?

    (difference_from_default * BigDecimal(100)) - BigDecimal(100)
  end

  def previous_report_from_default_branch
    @previous_report_from_default_branch = project.reports
                                                  .analysed
                                                  .with_profiler(profiler)
                                                  .created_before(created_at)
                                                  .where(branch: project.default_branch)
                                                  .where.not(id: id)
                                                  .newest
                                                  .first
  end

  def unit
    @unit ||= if profiler == 'memory'
                'mb'
              elsif profiler == 'request_time'
                'ms'
              else
                ''
              end
  end

  def unit_scaling_modifier
    @unit_scaling_modifier ||= profiler == 'memory' ? BigDecimal(1_048_576) : BigDecimal(1)
  end

  private

  def slug_candidates
    [profiler, SecureRandom.uuid].join('-')
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
