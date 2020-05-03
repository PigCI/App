class AddFailureLimitsToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :max_memory_in_megabytes, :decimal, default: 350.0
    add_column :projects, :max_memory_increase_percentage, :decimal, default: 5.0
    add_column :projects, :max_sql_active_record, :integer, default: 25
    add_column :projects, :max_sql_active_record_increase_percentage, :decimal, default: 5.0
    add_column :projects, :max_request_time_in_ms, :integer, default: 250
    add_column :projects, :max_request_time_increase_percentage, :decimal, default: 5.0
  end
end
