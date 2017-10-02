class Route < ApplicationRecord
  # Associations
  belongs_to :breakout
  belongs_to :user

  # Validations
  validates_presence_of :purchase_type, :price, :quality_type
  validates_numericality_of :price

  # Enum declarations
  enum purchase_type: [:buy, :sell]
  enum quality_type: [:cli, :non_cli]

  def self.get_matches(destination, breakout, price, purchase_type, quality_type)
    if purchase_type == "buy"
      self.where('(purchase_type= ? AND price <= ?)', 1, price.to_f)
    else
      self.where('(purchase_type= ? AND price >= ?)', 0, price.to_f)
    end
  end
end