class AddCompanyLocationColumnsInCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :street_address, :string
    add_column :companies, :state, :string
    add_column :companies, :postal_code, :string
    add_column :companies, :overview, :text
    add_column :companies, :since, :date
  end
end
