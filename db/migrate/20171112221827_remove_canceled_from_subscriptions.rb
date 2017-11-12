class RemoveCanceledFromSubscriptions < ActiveRecord::Migration[5.0]
  def change
    remove_column :subscriptions, :canceled, :boolean
  end
end
