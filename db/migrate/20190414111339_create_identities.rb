class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.string :provider, default: 'github'
      t.string :uid
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :identities, [:provider, :uid]
  end
end
