class AllowUserNameToBeNull < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :name, :string, default: '', null: true
  end

  def down
    change_column :users, :name, :string, default: '', null: false
  end
end
