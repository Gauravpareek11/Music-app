class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "notification_#{params[:sender_id]}"
  end

  def receive(data)
    # binding.pry
    Notification.create(sender_id: data['sender_id'], body: data['message'],recipient_id: data['recipient_id'])
  end
end
