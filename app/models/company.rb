class Company < ApplicationRecord
  has_many :users, dependent: :destroy

  validates_presence_of :name, :location, :website, :phone_no
  # validates_uniqueness_of :name
end
