class RenameProjectReportMaxesToHaveEasierFormat < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :max_memory_in_megabytes, :memory_max
    rename_column :projects, :max_memory_increase_percentage, :memory_max_increase_percentage

    rename_column :projects, :max_sql_active_record, :sql_active_record_max
    rename_column :projects, :max_sql_active_record_increase_percentage, :sql_active_record_max_increase_percentage

    rename_column :projects, :max_request_time_in_ms, :request_time_max
    rename_column :projects, :max_request_time_increase_percentage, :request_time_max_increase_percentage
  end
end
