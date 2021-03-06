class Search
  include ActiveModel::Model
  attr_accessor :destination, :breakout, :breakout_id, :price, :purchase_type, :quality_type

  # Validations
  validates :breakout_id, presence: {message: 'Please enter a Route or a Breakout and select one from a list that appears'}
  validates :price,
                  presence:     {message: 'Please enter a price'},
                  numericality: {
                                  greater_than_or_equal_to: 0.001,
                                  less_than_or_equal_to: 9.999,
                                  message: 'Price must be a number from 0.001 to 9.999'
                                }

  def self.create_paper_trail_version(search_params)
    PaperTrail::Version.create!(item_type: "Search", item_id: "0", event: "new", whodunnit: PaperTrail.whodunnit, object: search_params)
  end
end