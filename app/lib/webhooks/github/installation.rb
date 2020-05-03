class Webhooks::Github::Installation
  def initialize(payload)
    @payload = payload
  end

  def created!
    # Setup the install.
    @install = Install.find_or_create_by!(install_id: installation['id'], app_id: installation['app_id']) do |new_install|
      new_install.account_login = installation['account']['login']
    end

    # Create the identities, with users if required.
    found_or_created_identity = Identity.find_or_create_by!(provider: 'github', uid: sender['id']) do |identity|
      identity.user = User.find_or_initialize_with_password_by(
        email: install_service.client.user(sender['login']).email || "#{sender['id']}+#{sender['login']}@users.noreply.github.com",
        name: install_service.client.user(sender['login']).name
      )
    end

    # Add the new users to the install
    install.users << found_or_created_identity.user
    install.save!

    # Add the repos we're given access to also
    repositories.each do |repository|
      install.github_repositories.find_or_create_by!(github_id: repository[:id]) do |new_github_repository|
        new_github_repository.name = repository[:name]
        new_github_repository.full_name = repository[:full_name]
        new_github_repository.private = repository[:private]
      end
    end
  end

  def deleted!
    install.destroy!
  end

  private

  def installation
    @payload[:installation]
  end

  def repositories
    @payload[:repositories]
  end

  def sender
    @payload[:sender]
  end

  def install
    @install ||= Install.find_by!(install_id: installation['id'], app_id: installation['app_id'])
  end

  def install_service
    @install_service_client ||= InstallService.new(@install)
  end
end
