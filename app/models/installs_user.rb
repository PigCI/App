class InstallsUser < ApplicationRecord
  belongs_to :install, counter_cache: true
  belongs_to :user

  enum role: {
    owner: 'owner',
    contributor: 'contributor'
  }

  def to_s
    [install, user].join(' - ')
  end
end
