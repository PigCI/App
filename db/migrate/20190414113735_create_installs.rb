class CreateInstalls < ActiveRecord::Migration[5.2]
  def change
    create_table :installs do |t|
      t.string :account_login

      t.integer :app_id
      t.integer :install_id

      t.integer :installs_users_count, default: 0
      t.integer :projects_count, default: 0

      t.timestamps
    end
  end
end
