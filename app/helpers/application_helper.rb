module ApplicationHelper
  def show_errors(object, field_name)
    return unless object.errors.any?
    return if object.errors.messages[field_name].blank?

    object.errors.messages[field_name].join(', ')
  end
  def chat_count
    count=0
    conversations = current_user.sent_conversations.or(current_user.received_conversations)
    conversations.each do |conv|
      count+=conv.messages.where(read: false ).where.not(sender_id: current_user.id).count
    end
    return count
  end
  def notification_count
    count=notifications=current_user.received_notifications.where(read: false).count
    return count
  end
end
