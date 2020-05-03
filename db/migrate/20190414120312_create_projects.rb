class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :full_name
      t.string :api_key
      t.string :default_branch, default: 'master'
      t.boolean :private, default: false
      t.references :install, foreign_key: true
      t.string :slug

      t.timestamps
    end

    add_index :projects, :api_key, unique: true
    add_index :projects, :slug, unique: true
  end
end
