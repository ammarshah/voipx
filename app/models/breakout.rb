class Breakout < ApplicationRecord
  # Kaminari records per page declaration
  paginates_per 1000

  # Validations
  validates_presence_of :code, :destination
  validates_uniqueness_of :code
  validates :parent_id, numericality: true, allow_nil: true

  # Associations
  has_many :routes, dependent: :destroy

  def destination_autocomplete
    "#{self.destination} (#{self.code})"
  end

  def me_and_my_parents
    me_and_my_parents = []
    me_and_my_parents << self # include myself
    parent_id = self.parent_id

    until parent_id.nil?
      parent = Breakout.find_by_id(parent_id)
      me_and_my_parents << parent # add each parent of mine
      parent_id = parent.parent_id
    end

    me_and_my_parents
  end

  def me_and_my_children
    me_and_my_children = []
    me_and_my_children << self # include myself

    children = Breakout.where(parent_id: self.id).to_a

    children.each do |child|
      me_and_my_children << child # add each child/grandchild of mine
      
      grandchildren = Breakout.where(parent_id: child.id)
      grandchildren.each do |grandchild|
        children << grandchild
      end
    end

    me_and_my_children
  end
end