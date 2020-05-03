class GithubRepository < ApplicationRecord
  belongs_to :install
  belongs_to :project, dependent: :destroy, optional: true
  has_many :github_check_suites, dependent: :destroy

  validates :github_id, presence: true
  validates :name, presence: true
  validates :full_name, presence: true

  scope :without_a_project, -> { where(project: nil) }

  def to_s
    full_name
  end

  def default_branch
    github_info[:default_branch]
  end

  private

  def github_info
    @github_info ||= InstallService.new(install).client.repository(full_name)
  end
end
