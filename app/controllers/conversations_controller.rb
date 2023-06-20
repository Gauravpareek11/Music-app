class ConversationsController < ApplicationController
  def index
    @conversations = current_user.sent_conversations.or(current_user.received_conversations)
  end

  def create
    # binding.pry
    recipient = User.find(params[:conversation][:recipient_id])
    conversation = Conversation.between(current_user, recipient).first
    conversation ||= Conversation.create(sender: current_user, recipient: recipient)

    redirect_to conversation
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end
end
