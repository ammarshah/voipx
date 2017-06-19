class OtherProduct < ApplicationRecord
  # Associations
  belongs_to :company

  # Validations
  validates_presence_of :name
end
