class CreateGithubCheckSuites < ActiveRecord::Migration[5.2]
  def change
    create_table :github_check_suites do |t|
      t.bigint :github_id, foreign_key: true
      t.string :head_branch
      t.string :head_sha
      t.references :github_repository, foreign_key: true
      t.string :conclusion, default: 'neutral'
      t.string :status, default: 'queued'
      t.datetime :completed_at

      t.timestamps
    end
  end
end
