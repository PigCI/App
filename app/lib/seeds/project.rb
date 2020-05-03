class Seeds::Project
  def initialize(install: Install.last)
    @install = install
  end

  def save!
    project = ::Project.find_or_create_by!(
      name: 'PigCi',
      full_name: 'PigCI/PigCI',
      install: @install
    )

    ::GithubRepository.where(full_name: project.full_name).update(project: project)
  end
end
