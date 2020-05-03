class AddLastReportsCollectionAnalyedAtToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :last_analysed_at, :datetime
  end
end
