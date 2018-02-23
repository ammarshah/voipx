class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    recipient = User.where(id: conversation_params[:recipient])

    if current_user.contacts.pluck(:user_id).include?(recipient.first.id)
      conversation = current_user.send_message(recipient, conversation_params[:body], conversation_params[:subject]).conversation
      @message = {text: "Your message was successfully sent!", type: "success"}
    elsif current_user.allowed_to_send_message?
      Contact.create(owner: current_user, user: recipient.first) # Add recipient to current_user contact list if not already added
      conversation = current_user.send_message(recipient, conversation_params[:body], conversation_params[:subject]).conversation
      @message = {text: "Your message was successfully sent!", type: "success"}
    else
      @message_sent = false
      @message = {text: "You have 0 contact request left. You cannot send this message without upgrading your membership plan.", type: "error"}
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @receipts = conversation.receipts_for(current_user).order("created_at ASC")
    # mark conversation as read
    conversation.mark_as_read(current_user)
  end


  def reply
    recipient = conversation.participants.reject {|p| p.id == current_user.id}.last
    
    if current_user.contacts.pluck(:user_id).include?(recipient.id)
      current_user.reply_to_conversation(conversation, message_params[:body])
      redirect_to conversation_path(conversation), notice: "Your reply message was successfully sent!"
    elsif current_user.allowed_to_send_message?
      Contact.create(owner: current_user, user: recipient) # Add recipient to current_user contact list if not already added
      current_user.reply_to_conversation(conversation, message_params[:body])
      redirect_to conversation_path(conversation), notice: "Your reply message was successfully sent!"
    else
      redirect_to root_path, alert: "You have 0 contact request left. You cannot reply to this message without upgrading your membership plan."
    end
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end


  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body, :recipient)
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end
end
