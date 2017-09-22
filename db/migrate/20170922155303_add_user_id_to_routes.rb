class AddUserIdToRoutes < ActiveRecord::Migration[5.0]
  def change
    add_reference :routes, :user, foreign_key: true
  end
end
