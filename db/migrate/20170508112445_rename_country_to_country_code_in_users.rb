class RenameCountryToCountryCodeInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :country, :country_code
  end
end
