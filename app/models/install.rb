class Install < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :installs_users, dependent: :destroy
  has_many :users, through: :installs_users
  has_many :github_repositories, dependent: :destroy
  has_many :github_check_suites

  validates :account_login, presence: true
  validates :app_id, presence: true
  validates :install_id, presence: true

  def to_s
    ["app_id:#{app_id}", "install_id:#{install_id}", "account_login:#{account_login}"].join(',')
  end
end
