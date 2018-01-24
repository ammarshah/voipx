class AddDocumentToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :document, :string
  end
end
