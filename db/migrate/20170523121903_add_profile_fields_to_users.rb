class AddProfileFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :position, :string
    add_column :users, :about, :text
    add_column :users, :photo, :string
    add_column :users, :cover, :string
    add_column :users, :skype, :string
    add_column :users, :phone, :string
    add_column :users, :facebook_url, :string
    add_column :users, :twitter_url, :string
    add_column :users, :linkedin_url, :string
  end
end
