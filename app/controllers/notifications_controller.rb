# frozen_string_literal: true

# This is Notifications Controller
class NotificationsController < ApplicationController
  before_action :show_data
  before_action :authorize
  def index
    @notification = Notification.where(recipient_id: current_user.id) || []
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.sender = current_user
    return unless @notification.save

    NotificationMailer.notify(@notification).deliver_now
    broadcast_message(@notification)
  end

  def read
    current_user.received_notifications.update_all(read: true)
  end

  private

  def notification_params
    params[:notification][:body] = JSON.parse(params[:notification][:body])
    params.require(:notification).permit(:recipient_id, body: %i[name email])
  end

  def broadcast_message(notification)
    ActionCable.server.broadcast("notification_#{notification.recipient_id}", {
                                   sender: notification.sender.email,
                                   recipient_id: notification.recipient_id,
                                   message: notification.body
                                 })
  end
end
