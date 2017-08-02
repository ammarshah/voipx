class Route < ApplicationRecord
  # Associations
  belongs_to :breakout

  # Validations
  validates_presence_of :purchase_type, :price, :quality_type
  validates_numericality_of :price

  # Enum declarations
  enum purchase_types: [:buy, :sell]
  enum quality_types: [:cli, :non_cli]
end
