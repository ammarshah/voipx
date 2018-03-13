class RequestedBreakout < ApplicationRecord
  belongs_to :user

  validates_presence_of :destination, :breakout

  after_create :send_request_email

  private
  def send_request_email
    UserMailer.request_breakout(self).deliver_now
  end
end
