class ChangeFirstNameToNameInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :first_name, :name
  end
end
