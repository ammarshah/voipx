class RenameLocationInCompanies < ActiveRecord::Migration[5.0]
  def change
    rename_column :companies, :location, :country_code
  end
end
