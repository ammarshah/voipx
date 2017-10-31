class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :paypal_payer_id
      t.string :paypal_profile_id
      t.datetime :paid_until
      t.references :plan, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
