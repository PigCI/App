class ReportCollection < ApplicationRecord
  extend FriendlyId
  friendly_id :commit_sha1, use: [:finders, :slugged, :history, :scoped, :sequentially_slugged], scope: :project_id

  belongs_to :project
  has_many :reports, dependent: :destroy

  validates :commit_sha1, presence: true
  validates :branch, presence: true

  enum conclusion: GithubCheckSuite.conclusions, _prefix: :conclusion

  scope :analysed, ->{ where.not(last_analysed_at: nil) }

  def to_s
    [branch, commit_sha1[0, 7]].join('@')
  end

  def conclusion!
    return conclusion_failure! if reports.any?(&:conclusion_failure?)

    conclusion_success!
  end

  def last_analysed_at!
    touch(:last_analysed_at)
  end

  def github_check_suite?
    github_check_suite.present?
  end

  def github_check_suite
    @github_check_suite ||= project.github_check_suites.where(head_branch: branch, head_sha: commit_sha1).last
  end

  private

  def slug_candidates
    commit_sha1
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end
end
