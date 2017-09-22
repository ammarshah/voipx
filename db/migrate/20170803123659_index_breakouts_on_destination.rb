class IndexBreakoutsOnDestination < ActiveRecord::Migration[5.0]
  def change
    add_index :breakouts, :destination
  end
end
