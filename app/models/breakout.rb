class Breakout < ApplicationRecord
  validates_presence_of :code, :destination
  validates_uniqueness_of :code
end
