# frozen_string_literal: true

# This is Users Controller
class UsersController < ApplicationController
  before_action :authorize, only: %i[profile your_items your_requirements your_pending_approvals]
  before_action :show_data, only: %i[profile your_items your_requirements your_pending_approvals]
  before_action :logged_in, except: %i[profile your_items your_requirements your_pending_approvals]
  before_action :find_user, only: %i[profile your_items your_requirements your_pending_approvals]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, flash: { success: 'Signup Sucessfull' }
    else
      render :new
    end
  end

  def profile; end

  def your_items
    @posted_items = @user.products.my_seller
    @posted_items = apply_filtering(@posted_items, params)
    @posted_items = @posted_items.page(params[:page]).per(10)
  end

  def your_requirements
    @posted_require = @user.products.my_buyer
    @posted_require = apply_filtering(@posted_require, params)
    @posted_require = @posted_require.page(params[:page]).per(10)
  end

  def your_pending_approvals
    @pending_items = @user.products.unapproved_posts
    @pending_items = apply_filtering(@pending_items, params)
    @pending_items = @pending_items.page(params[:page]).per(10)
  end

  private

  def find_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
