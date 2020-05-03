class RemoveDefaultProfilerFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :default_profiler, :string, default: 'memory'
  end
end
