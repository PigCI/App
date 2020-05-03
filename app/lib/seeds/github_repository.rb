class Seeds::GithubRepository
  def initialize(install: Install.last)
    @install = install
  end

  def save!
    @install.github_repositories.find_or_create_by!(
      github_id: 146505263
    ) do |repository|
      repository.name = 'App'
      repository.full_name = 'PigCI/App'
      repository.private = true
    end
  end
end
