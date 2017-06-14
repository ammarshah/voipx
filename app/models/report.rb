class Report < ApplicationRecord
  # Paperclip
  has_attached_file :document
  validates_attachment :document, content_type: { content_type: %w(image/jpeg image/jpg image/png application/pdf application/msword) }
  
  # Associations
  belongs_to :company

  # Validations
  validates_presence_of :name, :document
end
