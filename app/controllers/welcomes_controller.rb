class WelcomesController < ApplicationController
  def index
    @items=Product.where.not(approved_by: nil)
    # binding.pry
    if(current_user)
      @notification=Notification.where(recipient_id: current_user.id)||[]
    else
      @notification=[]
    end
  end
end
