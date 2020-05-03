class Setup::GithubsController < ApplicationController
  # GET https://pigciapp.eu.ngrok.io/setup/github?installation_id=875487&setup_action=install
  def show
    return redirect_to user_github_omniauth_authorize_path unless current_user
  end
end
