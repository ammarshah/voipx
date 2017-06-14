class CreateReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :references do |t|
      t.string :contact_person
      t.string :name
      t.string :website
      t.string :email
      t.string :phone
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
