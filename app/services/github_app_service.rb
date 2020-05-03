class GithubAppService
  def client
    @client ||= Octokit::Client.new(bearer_token: jwt)
  end

  private

  def private_key
    @private_key ||= OpenSSL::PKey::RSA.new(
      Rails.application.credentials.dig(Rails.env.to_sym, :github, :private_key).gsub('\n', "\n")
    )
  end

  def app_identifier
    Rails.application.credentials.dig(Rails.env.to_sym, :github, :app_identifier)
  end

  def jwt
    @jwt ||= JWT.encode(
      {
        iat: Time.now.to_i,
        # JWT expiration time is (10 minute maximum), so set it to 9.
        exp: Time.now.to_i + (9 * 60),
        iss: app_identifier
      },
      private_key,
      'RS256'
    )
  end
end
