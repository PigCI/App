class InstallService
  def initialize(install)
    @install = install
    @app_id = install.app_id
    @install_id = install.install_id
  end

  def list_repositories
    client.list_app_installation_repositories
  end

  def client
    @client ||= Octokit::Client.new(bearer_token: installation_token)
  end

  def create_status(full_name, head_sha, status, options)
    client.create_status(full_name, head_sha, status, options)
  end

  private

  def installation_token
    @installation_token = github_app_service_client.create_app_installation_access_token(@install_id)[:token]
  end

  def github_app_service_client
    @github_app_service_client ||= GithubAppService.new.client
  end
end
