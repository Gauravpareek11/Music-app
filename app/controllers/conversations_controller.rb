# frozen_string_literal: true

# This is Conversations Controller
class ConversationsController < ApplicationController
  before_action :show_data
  before_action :restrict_messages, only: [:show]
  before_action :authorize
  before_action :restrict_admin

  def index
    @conversations = current_user.sent_conversations.or(current_user.received_conversations)
    @conversations = @conversations.page(params[:page]).per(10)
  end

  def create
    recipient = User.find(params[:conversation][:recipient_id])
    conversation = Conversation.between(current_user, recipient).first
    conversation ||= Conversation.create(sender: current_user, recipient:)

    redirect_to conversation
  end

  def show
    @conversation = Conversation.find(params[:id])
    @conversation.messages.where(read: false).where.not(sender_id: current_user.id).update_all(read: true)
    @message = Message.new
  end
end

private

def restrict_messages
  @id = Conversation.find(params[:id])
  return unless @id.sender_id != current_user.id && @id.recipient_id != current_user.id

  redirect_to root_path, flash: { error: 'Cannot show messages' }
end
