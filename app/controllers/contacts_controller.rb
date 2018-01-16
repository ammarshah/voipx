class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = current_user.contacts.includes(:user).order(created_at: :desc)
  end

  def create
    @contact = Contact.new(owner_id: current_user.id, user_id: params[:user_id])

    respond_to do |format|
      if @contact.save
        format.js
      else
        format.js
      end
    end
  end
  
end
