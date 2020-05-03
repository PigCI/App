class Users::SessionsController < Devise::SessionsController
  def new
    redirect_to user_github_omniauth_authorize_path
  end

  def create
    redirect_to user_github_omniauth_authorize_path
  end
end
