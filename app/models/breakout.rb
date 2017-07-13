class Breakout < ApplicationRecord
  paginates_per 1000

  validates_presence_of :code, :destination
  validates_uniqueness_of :code
end
