class CreateNotifiedMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :notified_matches do |t|
      t.integer :user_id
      t.integer :route_id
      t.integer :match_id
    end
    add_index :notified_matches, [:route_id, :match_id], unique: true
  end
end
