class AddInstallToGithubCheckSuite < ActiveRecord::Migration[5.2]
  def change
    add_reference :github_check_suites, :install
  end
end
