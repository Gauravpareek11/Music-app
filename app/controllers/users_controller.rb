# frozen_string_literal: true

# This is Users Controller
class UsersController < ApplicationController
  before_action :authorize, only: %i[profile your_items your_requirements]
  before_action :show_data, only: %i[profile your_items your_requirements]
  before_action :logged_in, except: %i[profile your_items your_requirements]
  before_action :find_user, only: %i[profile your_items your_requirements]

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

  def profile; end

  def your_items
    @posted_items = @user.products.seller.page(params[:page]).per(10)
  end

  def your_requirements
    @posted_require = @user.products.buyer.page(params[:page]).per(10)
  end

  private

  def find_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
