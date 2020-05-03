class AddCiConclusionToReportCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :report_collections, :conclusion, :string, default: 'neutral'
  end
end
