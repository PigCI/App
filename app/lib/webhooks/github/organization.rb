class Webhooks::Github::Organization
  def initialize(payload)
    @payload = payload
  end

  def member_removed!
    user = Identity.find_by(provider: 'github', uid: membership[:user][:id])&.user
    install.installs_users.where(user: user).destroy_all if user.present?
  end

  private

  def membership
    @payload[:membership]
  end

  def installation
    @payload[:installation]
  end

  def install
    @install ||= Install.find_by!(install_id: installation['id'])
  end
end
