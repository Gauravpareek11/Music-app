# frozen_string_literal: true

# This is Users Controller
class UsersController < ApplicationController
  before_action :authorize, only: [:profile]
  before_action :show_data, only: [:profile]
  before_action :logged_in, except: [:profile]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/', flash: { success: 'Signup Sucessfull' }
    else
      render :new
    end
  end

  def profile
    @user = User.find(params[:id])
    @posted_items = @user.products.seller.page(params[:page]).per(10)
    @posted_require = @user.products.buyer.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
