class Webhooks::Github::Repository
  def initialize(payload)
    @payload = payload
  end

  def renamed!
    github_repository.update(
      full_name: repository['full_name'],
      name: repository['name']
    )

    return unless project.present?

    project.update(
      full_name: repository['full_name'],
      name: repository['name']
    )
  end

  private

  def installation
    @payload[:installation]
  end

  def repository
    @payload[:repository]
  end

  def repository
    @payload[:repository]
  end

  def changes
    @payload[:changes]
  end

  def github_repository
    @github_repository ||= GithubRepository.find_by(github_id: repository['id'])
  end

  def project
    @project ||= github_repository.project
  end
end
