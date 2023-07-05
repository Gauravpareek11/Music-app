# frozen_string_literal: true

# This is Notification Mailer
class NotificationMailer < ApplicationMailer
  def notify(object)
    @obj = object
    mail(to: User.find(object.recipient_id).email, subject: 'Hi I am Interested in your post')
  end
end
