class Breakout < ApplicationRecord
  # Kaminari records per page declaration
  paginates_per 1000

  # Validations
  validates_presence_of :code, :destination
  validates_uniqueness_of :code

  # Associations
  has_many :routes, dependent: :destroy
end