class RemovePercentageChangesFromProject < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :memory_max_increase_percentage, :decimal, default: '15.0'
    remove_column :projects, :database_request_max_increase_percentage, :decimal, default: '20.0'
    remove_column :projects, :request_time_max_increase_percentage, :decimal, default: '25.0'
  end
end
