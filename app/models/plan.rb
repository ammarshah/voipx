class Plan < ApplicationRecord
  has_many :subscriptions

  validates :paypal_description, length: { maximum: 100 }

  def paypal_description=(value)
    write_attribute(:paypal_description, I18n.transliterate(value))
  end

  def to_s
    name
  end
end
