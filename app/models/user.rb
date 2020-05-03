class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged, :history]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable, :lockable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :identities, dependent: :destroy
  has_many :installs_users, dependent: :destroy
  has_many :installs, through: :installs_users
  has_many :github_repositories, through: :installs
  has_many :projects, through: :installs

  def self.build_from_github_omniauth(auth)
    email_address = auth.info[:email].presence || "#{auth.info[:id]}+#{auth.info[:login]}@users.noreply.github.com"

    new_user = find_or_initialize_by(email: email_address) do |user|
      user.name = auth.info[:name]
      user.password = Devise.friendly_token[0, 64]
    end

    new_user
  end

  def self.find_or_initialize_with_password_by(email:, name:)
    find_or_initialize_by(email: email) do |user|
      user.name = name
      user.password = Devise.friendly_token[0, 64]
    end
  end

  def avatar_url
    identities.first&.avatar_url || 'logo_pigci.svg'
  end

  def to_s
    name || 'Buddy'
  end

  private

  def slug_candidates
    [name, SecureRandom.uuid[0..7]].join('-')
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  protected

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
