class RemoveNotNullConstraintFromMobileNoInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :mobile_no, :string, null: true
  end
end
