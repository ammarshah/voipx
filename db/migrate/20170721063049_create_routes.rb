class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.integer :purchase_type
      t.float :price
      t.integer :quality_type
      t.references :breakout, foreign_key: true

      t.timestamps
    end
  end
end
