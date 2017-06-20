class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.string :alpha2
      t.string :alpha3
      t.string :phone_code

      t.timestamps
    end
  end
end
