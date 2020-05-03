class AddSlugsToReportsAndReportCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :slug, :string, index: true
    add_column :report_collections, :slug, :string, index: true
  end
end
