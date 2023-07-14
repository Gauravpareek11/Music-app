# frozen_string_literal: true

# This is Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :admin?
  before_action :set_nil
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to '/login' unless current_user
  end

  def admin?
    current_user&.admin
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

  def restrict_admin
    redirect_to '/', flash: { error: 'Admin Not allowed' } if admin?
  end

  def set_nil
    session[:item] = nil
  end
end
