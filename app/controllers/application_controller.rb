# frozen_string_literal: true

# This is Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user, :is_admin?

  def authorize
    redirect_to '/login' unless current_user
  end

  def admin?
    return unless current_user&.admin
  end

  def restrict_user
    redirect_to '/', flash: { error: 'Not Admin' } unless admin?
  end

  def show_data
    @notification = if current_user
                      Notification.where(recipient_id: current_user.id) || []
                    else
                      []
                    end
  end

  def logged_in
    redirect_to '/', flash: { error: 'Already Signed In' } if current_user
  end
end
