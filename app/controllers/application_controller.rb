# frozen_string_literal: true

# This is Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_method
  helper_method :current_user, :admin?
  before_action :set_nil

  def not_found_method
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to login_path, flash: { success: 'Please Sign In' } unless current_user
  end

  def admin?
    current_user&.admin
  end

  def restrict_user
    redirect_to root_path, flash: { error: 'Not Admin' } unless admin?
  end

  def show_data
    @notification = if current_user
                      Notification.where(recipient_id: current_user.id, read: false) || []
                    else
                      []
                    end
  end

  def logged_in
    redirect_to root_path, flash: { error: 'Already Signed In' } if current_user
  end

  def restrict_admin
    redirect_to root_path, flash: { error: 'Admin Not allowed' } if admin?
  end

  def set_nil
    session[:item] = nil
  end

  def apply_filtering(prod, params)
    prod = prod.where(category_id: params[:category]) if params[:category].present?
    prod = prod.where(sub_category_id: params[:sub_category]) if params[:sub_category].present?
    prod = prod.where('location ilike ?', "%#{params[:location]}%") if params[:location].present?
    prod
  end
end
