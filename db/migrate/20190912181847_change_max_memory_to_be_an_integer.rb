class ChangeMaxMemoryToBeAnInteger < ActiveRecord::Migration[6.0]
  def up
    add_column :projects, :memory_max_in_bytes, :bigint, default: (BigDecimal(1_048_576) * 350).to_i, null: false

    Project.reset_column_information

    Project.find_each do |project|
      project.update_column(:memory_max_in_bytes, (project.attributes['memory_max'] * BigDecimal(1_048_576)).to_i)
    end

    remove_column :projects, :memory_max
  end

  def down
    add_column :projects, :memory_max, :decimal, default: '350.0'
    remove_column :projects, :memory_max_in_bytes
  end
end
