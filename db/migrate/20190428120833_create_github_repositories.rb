class CreateGithubRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :github_repositories do |t|
      t.bigint :github_id, foreign_key: true
      t.string :name
      t.string :full_name
      t.boolean :private, default: false
      t.references :install, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
