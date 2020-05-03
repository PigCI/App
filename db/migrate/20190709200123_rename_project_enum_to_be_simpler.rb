class RenameProjectEnumToBeSimpler < ActiveRecord::Migration[6.0]
  def up
    Report.where(profiler: 'sql_active_record').update_all(profiler: 'database_request')
    Report.where(profiler: 'instantiation_active_record').update_all(profiler: 'database_object_instantiation')
  end

  def down
    Report.where(profiler: 'database_request').update_all(profiler: 'sql_active_record')
    Report.where(profiler: 'database_object_instantiation').update_all(profiler: 'instantiation_active_record')
  end
end
