class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :report_collection, foreign_key: true
      t.references :project, foreign_key: true
      t.decimal :max, precision: 14, default: "0"
      t.decimal :max_difference_from_default_branch, default: "0.0"
      t.decimal :min, precision: 14, default: "0"
      t.decimal :min_difference_from_default_branch, default: "0.0"
      t.decimal :total_requests, default: "0.0"
      t.datetime :analysed_at
      t.string :profiler, default: 'memory'
      t.string :branch, default: "master"

      t.timestamps
    end
  end
end
