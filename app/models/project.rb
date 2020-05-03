class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[finders slugged history]

  belongs_to :install, counter_cache: true
  has_one :github_repository, dependent: :nullify
  has_many :github_check_suites, through: :github_repository
  has_many :reports
  has_many :report_collections, dependent: :destroy

  validates :name, presence: true
  validates :full_name, presence: true
  validates :api_key, presence: true, uniqueness: true
  validates :default_branch, presence: true
  validates :api_key, presence: true
  validates :memory_max, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :database_request_max, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :request_time_max, presence: true, numericality: { greater_than: 0, only_integer: true }

  before_validation :generate_api_key, unless: :api_key?

  def to_s
    name
  end

  def last_analysed_at!
    touch(:last_analysed_at)
  end

  def lastest_default_branch_report_collection
    @lastest_default_branch_report_collection ||= report_collections
                                                  .analysed
                                                  .where(branch: default_branch)
                                                  .newest
                                                  .includes(:reports)
                                                  .first
  end

  def lastest_default_branch_report_collection?
    lastest_default_branch_report_collection.present?
  end

  def lastest_report_collection
    @lastest_report_collection ||= lastest_default_branch_report_collection || report_collections.newest.includes(:reports).first
  end

  def lastest_report_collection?
    lastest_report_collection.present?
  end

  def pr_limits_changed?
    saved_changes.keys.any? do |key|
      key.in?(%w[memory_max database_request_max request_time_max])
    end
  end

  def memory_max
    @memory_max ||= ((memory_max_in_bytes || 1) / BigDecimal(1_048_576)).to_i
  end

  def memory_max=(value)
    @memory_max = nil
    self.memory_max_in_bytes = value.to_i * BigDecimal(1_048_576)
  end

  private

  def generate_api_key
    self.api_key = loop do
      token = SecureRandom.urlsafe_base64(32)
      break token unless Project.unscoped.exists?(api_key: token)
    end
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
