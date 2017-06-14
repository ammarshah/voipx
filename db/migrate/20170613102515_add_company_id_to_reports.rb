class AddCompanyIdToReports < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :company_id, :integer
    add_index :reports, :company_id
  end
end
