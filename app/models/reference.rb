class Reference < ApplicationRecord
  # Associations
  belongs_to :company

  # Validations
  validates_presence_of :contact_person, :name, :website, :email, :phone
end
