class GithubCheckSuite < ApplicationRecord
  belongs_to :github_repository
  belongs_to :install

  enum conclusion: {
    pending: 'pending',
    success: 'success',
    failure: 'failure',
    neutral: 'neutral',
    cancelled: 'cancelled',
    timed_out: 'timed_out',
    action_required: 'action_required'
  }, _prefix: :conclusion

  enum status: {
    queued: 'queued',
    in_progress: 'in_progress',
    completed: 'completed'
  }, _prefix: :status

  validates :github_id, presence: true
  validates :head_branch, presence: true
  validates :head_sha, presence: true

  def description
    I18n.t(conclusion, scope: %w[activerecord helpers github_check_suite description])
  end

  def github_status
    if conclusion_failure?
      :failure
    elsif conclusion_pending?
      :pending
    else
      :success
    end
  end
end
