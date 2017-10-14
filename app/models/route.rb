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


  def self.filter_breakout_or_destinations(breakout = nil, destinations = [], purchase_type)
    return all if (breakout.blank? and destinations.blank?)
    
    if breakout.blank?
      where(breakout: destinations)
    else
      case purchase_type
      when "buy"
        where('(purchase_type = ? AND breakout_id IN (?))', purchase_types["sell"], breakout.me_and_my_parents)
      when "sell"
        where('(purchase_type = ? AND breakout_id IN (?))', purchase_types["buy"], breakout.me_and_my_children)
      else # when 'any'
        where('(purchase_type = ? AND breakout_id IN (?)) OR (purchase_type = ? AND breakout_id IN (?))',
            purchase_types["buy"], breakout.me_and_my_children,
            purchase_types["sell"], breakout.me_and_my_parents)
      end
    end
  end

  def self.filter_finder(finder)
    where.not(user: finder)
  end

  def self.filter_purchase_type(purchase_type)
    case purchase_type
    when "buy", "sell"
      where.not(purchase_type: purchase_type)
    else # when 'any'
      where(purchase_type: ["buy", "sell"])
    end
  end

  def self.filter_quality_type(quality_type)
    case quality_type
    when "cli", "non_cli"
      where(quality_type: quality_type)
    else # when 'any'
      where(quality_type: ["cli", "non_cli"])
    end
  end

  def self.filter_price(price = nil, purchase_type)
    return all if price.blank?

    case purchase_type
    when "buy"
      where('price <= ?', price.to_f)
    when "sell"
      where('price >= ?', price.to_f)
    else # when 'any'
      where('(purchase_type = ? AND price <= ?) OR (purchase_type = ? AND price >= ?)',
            purchase_types["sell"], price.to_f,
            purchase_types["buy"], price.to_f)
    end
  end

  def self.get_matches(search_params, finder = nil)
    destinations, breakout, purchase_type, quality_type, price = Breakout.where("destination ILIKE ?", "%#{search_params[:destination]}%"), Breakout.find_by_code(search_params[:breakout]), search_params[:purchase_type], search_params[:quality_type], search_params[:price]

    self.filter_breakout_or_destinations(breakout, destinations, purchase_type)
        .filter_finder(finder)
        .filter_purchase_type(purchase_type)
        .filter_quality_type(quality_type)
        .filter_price(price, purchase_type)
  end
end
