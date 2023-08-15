# frozen_string_literal: true

# This is session Controller
class SessionsController < ApplicationController
  before_action :authorize, only: [:destroy]
  before_action :logged_in, except: [:destroy]

  def new; end

  def create
    user = User.find_by_email(params[:email]&.downcase)
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, flash: { success: 'Successfully logged in' }
    else
      redirect_to login_path, flash: { error: 'Invalid email id or password' }
    end
  end

  def omni_create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, flash: { success: 'Successfully logged in' }
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, flash: { success: 'You are successfully logged out' }
  end
end
