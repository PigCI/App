class AddConclusionToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :conclusion, :string, default: 'neutral'
  end
end
