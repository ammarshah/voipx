class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = current_user.contacts.includes(:user).order(created_at: :desc)
  end
end
