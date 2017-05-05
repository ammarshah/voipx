class ChangeFirstNameNotToBeNullInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :first_name, :string, null: false
  end
end
