class ConversationsController < ApplicationController
  before_action :show_data
  before_action :restrict_messages,only: [:show]
  before_action :authorize
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
    @conversation.messages.where(read: false ).where.not(sender_id: current_user.id).update_all(read: true)
    @message = Message.new
  end
end
private
def restrict_messages
  @id=Conversation.find(params[:id])
  # binding.pry
  if(@id.sender_id!=current_user.id && @id.recipient_id!=current_user.id)
    redirect_to '/',notice:"Cannot show messages"
  end
end
