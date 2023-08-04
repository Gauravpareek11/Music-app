# frozen_string_literal: true

# This is Application Helper
module ApplicationHelper
  def show_errors(object, field_name)
    return unless object.errors.any?
    return if object.errors.messages[field_name].blank?

    object.errors.messages[field_name].join(', ')
  end

  def chat_count
    count = 0
    if current_user
      conversations = current_user.sent_conversations.or(current_user.received_conversations)
      conversations.each do |conv|
        count += conv.messages.where(read: false).where.not(sender_id: current_user.id).count
      end
    end
    count
  end

  def notification_count
    count = 0
    count = current_user.received_notifications.where(read: false).count if current_user
    count
  end

  def find_subcategory
    Category.find(params[:category]).sub_categories.pluck(:items, :id)
  end

  def find_category
    Category.pluck(:items, :id)
  end
end
