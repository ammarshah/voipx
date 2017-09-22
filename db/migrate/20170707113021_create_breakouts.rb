class CreateBreakouts < ActiveRecord::Migration[5.0]
  def change
    create_table :breakouts do |t|
      t.string :code
      t.string :destination
      t.integer :parent_id

      t.timestamps
    end
    add_index :breakouts, :code, unique: true
  end
end
