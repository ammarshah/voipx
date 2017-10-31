class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token

  belongs_to :plan
  belongs_to :user

  delegate :price, :paypal_description, to: :plan

  def cancel!
    update(cancel: true)
  end

  def paid?
    return false if paid_until.blank?
    paid_until >= Time.current
  end
end
