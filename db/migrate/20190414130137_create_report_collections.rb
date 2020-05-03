class CreateReportCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :report_collections do |t|
      t.string :commit_sha1
      t.datetime :last_analysed_at
      t.string :branch, default: 'master'
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
