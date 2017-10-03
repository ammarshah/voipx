class Breakout < ApplicationRecord
  # Kaminari records per page declaration
  paginates_per 3000

  # Validations
  validates_presence_of :code, :destination
  validates_uniqueness_of :code
  validates :parent_id, numericality: true, allow_nil: true

  # Associations
  has_many :routes, dependent: :destroy
end