class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.string :paypal_description
      t.text :description
    end
  end
end
