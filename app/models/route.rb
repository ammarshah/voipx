class Route < ApplicationRecord
  # Associations
  belongs_to :breakout

  # Validations
  validates_presence_of :purchase_type, :price, :quality_type
  validates_numericality_of :price

  # Enum declarations
  enum purchase_type: [:buy, :sell]
  enum quality_type: [:cli, :non_cli]
end
