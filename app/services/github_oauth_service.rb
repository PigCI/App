class GithubOauthService
  def initialize(access_token)
    @access_token = access_token
  end

  def client
    @client ||= Octokit::Client.new(access_token: @access_token)
  end

  def installations
    client.get('user/installations', accept: 'application/vnd.github.machine-man-preview+json').installations || []
  end
end
