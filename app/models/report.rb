class Report < ApplicationRecord
  # CarrierWave
  mount_uploader :document, DocumentUploader
  
  # Associations
  belongs_to :company

  # Validations
  validates_presence_of :name, :document
end
