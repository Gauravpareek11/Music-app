class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user,:is_admin?

    def authorize
        redirect_to '/login' unless current_user
    end
    def is_admin?
        # binding.pry
        current_user && current_user.admin
    end

    def restrict_user
        redirect_to '/',flash: {error: "Not Admin"} unless is_admin?
    end
    def show_data
        if(current_user)
          @notification=Notification.where(recipient_id: current_user.id)||[]
        else
          @notification=[]
        end
    end
end
