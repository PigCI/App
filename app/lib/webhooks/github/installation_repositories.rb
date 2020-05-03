class Webhooks::Github::InstallationRepositories
  def initialize(payload)
    @payload = payload
  end

  def added!
    repositories_added.each do |repository|
      install.github_repositories.find_or_create_by!(github_id: repository[:id]) do |new_github_repository|
        new_github_repository.name = repository[:name]
        new_github_repository.full_name = repository[:full_name]
        new_github_repository.private = repository[:private]
      end
    end
  end

  def removed!
    repositories_removed.each do |repository|
      install.github_repositories.where(github_id: repository[:id]).destroy_all
    end
  end

  private

  def installation
    @payload[:installation]
  end

  def repositories
    @payload[:repositories]
  end

  def sender
    @payload[:sender]
  end

  def repositories_added
    @payload[:repositories_added]
  end

  def repositories_removed
    @payload[:repositories_removed]
  end

  def install
    @install ||= Install.find_by!(install_id: installation['id'], app_id: installation['app_id'])
  end

  def install_service
    @install_service_client ||= InstallService.new(@install)
  end
end
