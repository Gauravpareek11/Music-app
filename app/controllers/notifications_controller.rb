class NotificationsController < ApplicationController
  def index
    @notification=Notification.where(recipient_id: current_user.id)||[]
  end
  def create
    @notification=Notification.new(notification_params)
    @notification.sender = current_user
    # @notification.body=@notification.body.to_json
    # @notification.recipient = params[:recipient_id]
    # binding.pry
    if @notification.save
      # puts '5'
      NotificationMailer.notify(@notification).deliver_now
      ActionCable.server.broadcast("notification_#{@notification.recipient_id}", {
        sender: @notification.sender.email,
        recipient_id: @notification.recipient_id,
        message: @notification.body
      })
      # redirect_to @conversation
      # head :ok
    else
      redirect_to '/'
    end
  end
  private
  def notification_params
    # binding.pry
    params[:notification][:body]=JSON.parse(params[:notification][:body])
    # binding.pry
    params.require(:notification).permit(:recipient_id,body: [:name,:age])
  end
end
