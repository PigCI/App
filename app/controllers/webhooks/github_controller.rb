class Webhooks::GithubController < ActionController::API
  include GithubWebhook::Processor

  # Just for now skip these from github_webhook gem, while I figure out all the tests I need to write for this.
  skip_before_action :check_github_event!
  skip_before_action :authenticate_github_request!

  def github_installation(payload)
    Webhooks::Github::Installation.new(payload).created! if payload[:action] == 'created'
    Webhooks::Github::Installation.new(payload).deleted! if payload[:action] == 'deleted'
    # TODO: new_permissions_accepted
  end

  def github_integration_installation(payload)
    # Deprecated - I just wanted to stop HTTP errors.
  end

  def github_installation_repositories(payload)
    Webhooks::Github::InstallationRepositories.new(payload).added! if payload[:action] == 'added'
    Webhooks::Github::InstallationRepositories.new(payload).removed! if payload[:action] == 'removed'
  end

  def github_integration_installation_repositories(payload)
    # Deprecated - I just wanted to stop HTTP errors.
  end

  def github_marketplace_purchase(payload)
  end

  def github_check_suite(payload)
    Webhooks::Github::CheckSuite.new(payload).requested! if payload[:action] == 'requested'
    Webhooks::Github::CheckSuite.new(payload).rerequested! if payload[:action] == 'rerequested'
  end

  def github_status(payload)
    # When status changes, often by us.
  end

  def github_github_app_authorization(payload)
    Webhooks::Github::GithubAppAuthorization.new(payload).revoked! if payload[:action] == 'revoked'
  end

  def github_check_run(payload)
    # When something is created via check_suite
  end

  def github_repository_event(payload)
    # A repo is created/renamed/deleted
    # https://developer.github.com/v3/activity/events/types/#repositoryevent
  end

  def github_organization(payload)
    Webhooks::Github::Organization.new(payload).member_removed! if payload[:action] == 'member_removed'
  end

  def github_organization_event(payload)
    # Someone is added/removed from an organisation, or an organisation is renamed
    # https://developer.github.com/v3/activity/events/types/#organizationevent
  end

  def github_repository(payload)
    Webhooks::Github::Repository.new(payload).renamed! if payload[:action] == 'renamed'
    # Repo changed or something.
  end
end
