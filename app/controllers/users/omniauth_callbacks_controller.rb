class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    identity = Identity.from_omniauth(auth).first_or_initialize

    # Build the user if it doesn't exist already
    if identity.user.nil?
      identity.user = User.build_from_github_omniauth(auth)
      identity.save
    end

    if identity.persisted? && identity.user.persisted?
      add_user_to_installs!(identity.user)

      identity.user.remember_me = true
      sign_in_and_redirect(identity.user, event: :authentication)
      set_flash_message(:notice, :success, kind: "GitHub") if is_navigational_format?
    else
      raise identity.user.errors.inspect
      redirect_to root_path, alert: t('.alert')
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def add_user_to_installs!(user)
    installations = GithubOauthService.new(auth.credentials['token']).installations

    Install.where(install_id: installations.collect(&:id)).each do |install|
      install.installs_users.find_or_create_by(user: user)
    end
  end

  def after_sign_in_path_for(resource)
    if resource.installs.any?
      session.dig('user_return_to') || projects_path
    else
      setup_github_path(setup_action: 'no_install')
    end
  end

  def auth
    request.env['omniauth.auth']
  end
end
