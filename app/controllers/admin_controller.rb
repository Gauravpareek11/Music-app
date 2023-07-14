# frozen_string_literal: true

# This Admin Controller
class AdminController < ApplicationController
  before_action :show_data
  before_action :restrict_user
  def index; end

  def pending_approvals
    @sell = Product.unapproved_sellers
    @buy = Product.unapproved_buyers
  end

  def edit
    @items = Product.find(params[:id])
  end

  def update
    @items = Product.find(params[:id])
    if @items.update({ approved_by: current_user.id })
      redirect_to '/', flash: { success: 'Item Approved' }
    else
      render 'edit'
    end
  end
end
