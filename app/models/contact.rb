class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :owner, class_name: 'User'

  validate :contacts_left, on: :create

  private
  def allowed_to_add_contact?
    owner.has_subscribed_to_pro_plan? || (owner.has_subscribed_to_basic_plan? && owner.contacts.size < 5)
  end

  def contacts_left
    if allowed_to_add_contact?
      return true
    else
      errors.add(:base, "You have 0 contact request left. Please upgrade your membership plan.")
      return false
    end
  end
end
