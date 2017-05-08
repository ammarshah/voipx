class RemoveNotNullConstraintFromCountryCodeInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :country_code, :string, null: true
  end
end
