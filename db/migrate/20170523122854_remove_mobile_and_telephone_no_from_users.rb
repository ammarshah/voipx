class RemoveMobileAndTelephoneNoFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :telephone_no
    remove_column :users, :mobile_no
  end
end
