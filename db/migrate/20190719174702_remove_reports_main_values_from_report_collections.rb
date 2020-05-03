class RemoveReportsMainValuesFromReportCollections < ActiveRecord::Migration[6.0]
  def change
    remove_column :report_collections, :reports_main_values, :jsonb, default: '{}'
  end
end
