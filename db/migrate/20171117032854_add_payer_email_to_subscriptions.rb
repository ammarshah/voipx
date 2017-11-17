class AddPayerEmailToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :paypal_payer_email, :string
  end
end
