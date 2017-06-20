class CreateJoinTableSellingCountries < ActiveRecord::Migration[5.0]
  def change
    create_table 'selling_countries', id: false do |t|
      t.integer :country_id, null: false
      t.integer :company_id, null: false
    end
    add_index(:selling_countries, [:country_id, :company_id])
  end
end
