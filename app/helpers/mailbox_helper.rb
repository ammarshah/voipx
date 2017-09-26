module MailboxHelper
  def unread_messages_count
    mailbox.inbox(:unread => true).count(:id)
  end
end
