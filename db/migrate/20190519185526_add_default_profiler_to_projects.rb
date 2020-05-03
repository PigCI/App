class AddDefaultProfilerToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :default_profiler, :string, default: 'memory'
  end
end
