class Identity < ApplicationRecord
  belongs_to :user

  enum provider: {
    github: 'github'
  }

  validates :provider, presence: true
  validates :uid, presence: true

  scope :from_omniauth, ->(auth) { where(provider: auth.provider, uid: auth.uid) }

  def avatar_url
    "https://avatars3.githubusercontent.com/u/#{uid}"
  end
end
