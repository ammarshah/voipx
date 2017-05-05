class AddMobileNoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mobile_no, :string, null: false
  end
end
