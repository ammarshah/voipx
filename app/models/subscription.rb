class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token

  belongs_to :plan
  belongs_to :user

  delegate :price, :paypal_description, to: :plan

  def paid?
    return false if paid_until.blank?
    paid_until >= Time.current
  end

  def status
    if paid_until.nil?
      status = "running"
    elsif paid_until.to_date == created_at.to_date
      status = "payment_pending"
    elsif paid?
      status = "paid"
    else
      status = "invalid_status"
    end

    return status
  end
end
