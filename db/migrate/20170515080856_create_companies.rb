class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.string :website
      t.string :phone_no

      t.timestamps
    end
  end
end
