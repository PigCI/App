class Webhooks::Github::GithubAppAuthorization
  def initialize(payload)
    @payload = payload
  end

  def revoked!
    return unless identity.present?

    if identity.user&.present?
      identity.user.destroy
    else
      identity.destroy
    end
  end

  private

  def sender
    @payload[:sender]
  end

  def identity
    @identity = Identity.where(provider: 'github', uid: sender[:id]).first
  end
end
