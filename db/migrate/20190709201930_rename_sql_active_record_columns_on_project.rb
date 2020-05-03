class RenameSqlActiveRecordColumnsOnProject < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :sql_active_record_max, :database_request_max
    rename_column :projects, :sql_active_record_max_increase_percentage, :database_request_max_increase_percentage
  end
end
