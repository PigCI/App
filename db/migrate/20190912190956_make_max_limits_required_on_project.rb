class MakeMaxLimitsRequiredOnProject < ActiveRecord::Migration[6.0]
  def up
    change_column :projects, :database_request_max, :integer, default: 35, null: false
    change_column :projects, :request_time_max, :integer, default: 250, null: false
  end

  def down
    change_column :projects, :database_request_max, :integer, default: 35
    change_column :projects, :request_time_max, :integer, default: 250
  end
end
