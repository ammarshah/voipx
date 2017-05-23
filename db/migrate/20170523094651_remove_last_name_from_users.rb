class RemoveLastNameFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :last_name
  end
end
