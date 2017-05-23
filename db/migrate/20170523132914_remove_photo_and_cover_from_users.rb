class RemovePhotoAndCoverFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :photo
    remove_column :users, :cover
  end
end
