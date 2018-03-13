class CreateRequestedBreakouts < ActiveRecord::Migration[5.0]
  def change
    create_table :requested_breakouts do |t|
      t.string :destination, null: false
      t.string :breakout, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
