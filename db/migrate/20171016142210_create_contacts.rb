class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.references :user
      t.references :owner

      t.timestamps
    end
  end
end
