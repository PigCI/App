class Webhooks::Github::CheckSuite
  def initialize(payload)
    @payload = payload
  end

  def requested!
    github_check_suite.save!
    install_service.create_status(repository['full_name'], check_suite['head_sha'], github_check_suite.github_status, status_pending_options)
  end

  def rerequested!
    # Recheck if we have the report yet, update if we got a newer report.
  end

  private

  def status_pending_options
    {
      context: 'PigCI',
      description: github_check_suite.description,
      target_url: Rails.application.routes.url_helpers.projects_url
    }
  end

  def installation
    @payload[:installation]
  end

  def repository
    @payload[:repository]
  end

  def check_suite
    @payload[:check_suite]
  end

  def github_check_suite
    @github_check_suite ||= install.github_check_suites.find_or_create_by!(github_id: check_suite['id']) do |new_github_check_suite|
      new_github_check_suite.github_repository = github_repository
      new_github_check_suite.head_branch = check_suite['head_branch']
      new_github_check_suite.head_sha = check_suite['head_sha']
      if github_repository.project.present?
        new_github_check_suite.conclusion = :pending
        new_github_check_suite.status = :queued
      else
        new_github_check_suite.conclusion = :action_required
        new_github_check_suite.status = :completed
      end
      # new_github_check_suite.report_collection = nil # Find on the fly.
    end
  end

  def github_repository
    @github_repository ||= GithubRepository.find_by(github_id: repository['id'])
  end

  def install
    @install ||= Install.find_by!(install_id: installation['id'])
  end

  def install_service
    @install_service ||= InstallService.new(install)
  end
end
