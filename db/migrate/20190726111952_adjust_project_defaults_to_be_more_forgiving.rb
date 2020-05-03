class AdjustProjectDefaultsToBeMoreForgiving < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :memory_max, :decimal, default: '350.0'
    change_column :projects, :memory_max_increase_percentage, :decimal, default: '15.0'

    change_column :projects, :database_request_max, :integer, default: 35
    change_column :projects, :database_request_max_increase_percentage, :decimal, default: '20.0'

    change_column :projects, :request_time_max, :integer, default: 250
    change_column :projects, :request_time_max_increase_percentage, :decimal, default: '25.0'
  end
end
