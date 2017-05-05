class AddTelephoneNoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :telephone_no, :string, null: false
  end
end
