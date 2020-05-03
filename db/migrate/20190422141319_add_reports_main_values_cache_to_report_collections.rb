class AddReportsMainValuesCacheToReportCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :report_collections, :reports_main_values, :jsonb, default: '{}'
  end
end
