class NotificationMailer < ApplicationMailer
  def notify(object)
    @obj=object
    mail(to: 'mahfuzflamedestiny@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
