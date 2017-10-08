class Route < ApplicationRecord
  # Associations
  belongs_to :breakout, optional: true # This `optional: true` parameter is just to avoid default belongs_to association error message 'must exist' from rails.
                                       # Because we have specified our own validation for presence of breakout below and skipped all attribute names from validation error messages in en.yml locale file.
  belongs_to :user

  # Validations
  validates :purchase_type, presence: {message: 'Please specify if you are buying or selling this route'}
  validates :quality_type, presence: {message: 'Please select a route type'}
  validates :price,
                  presence:     {message: 'Please enter a price'},
                  numericality: {
                                  greater_than_or_equal_to: 0.001,
                                  less_than_or_equal_to: 9.999,
                                  message: 'Price must be a number from 0.001 to 9.999'
                                }
  validates :breakout, presence: {message: 'Please enter a Route or a Breakout and select one from a list that appears'} # custom validation message for belongs_to association defined above with `optional: true` paramater, which was obviously not required.


  # Enum declarations
  enum purchase_type: [:buy, :sell]
  enum quality_type: [:cli, :non_cli]

  def self.get_matches(search_params)
    destination, breakout, price, purchase_type, quality_type = search_params[:destination], search_params[:breakout], search_params[:price], search_params[:purchase_type], search_params[:quality_type]
    
    if purchase_type == "buy"
      self.where('(purchase_type= ? AND price <= ?)', 1, price.to_f)
    else
      self.where('(purchase_type= ? AND price >= ?)', 0, price.to_f)
    end
  end
end
