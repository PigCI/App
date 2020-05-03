class CreateInstallsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :installs_users do |t|
      t.references :user, foreign_key: true
      t.references :install, foreign_key: true
      t.string :role, default: 'owner'

      t.index [:user_id, :install_id]

      t.timestamps
    end
  end
end
