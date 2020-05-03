class Slack::UsageSummaryJob < ApplicationJob
  queue_as :slack

  def perform
    client.chat_postMessage(channel: 'pig-ci', text: text, as_user: true)
  end

  private

  def text
    [
      "📊📋 *Usage Summary* 📋📊",
      "Installs: #{Install.count}",
      "Identities: #{Identity.count}",
      "Users:  #{User.count}",
      "Github Repositories: #{GithubRepository.count}",
      "Projects: #{Project.count}"
    ].join("\n")
  end

  def client
    @client ||= Slack::Web::Client.new(token: Rails.application.credentials.dig(Rails.env.to_sym, :slack, :bot_user_oauth_access_token))
  end
end
