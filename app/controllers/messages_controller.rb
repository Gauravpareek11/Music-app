# frozen_string_literal: true

# This is Messages Controller
class MessagesController < ApplicationController
  before_action :show_data
  before_action :restrict_admin

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user
    @message.recipient = @conversation.opposed_user(current_user)

    if @message.save
      broadcast_chat(@message, @conversation)
    else
      render 'conversations/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def broadcast_chat(message, conversation)
    ActionCable.server.broadcast("chat_#{conversation.id}", {
                                   sender: message.sender.email,
                                   message: message.body
                                 })
  end
end
