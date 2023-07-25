# frozen_string_literal: true

# This Admin Controller
class AdminController < ApplicationController
  before_action :show_data
  before_action :restrict_user
  before_action :find_prod, only: %i[edit update reject_post]
  def index; end

  def pending_approvals
    @sell = Product.unapproved_sellers.page(params[:page]).per(10)
    @buy = Product.unapproved_buyers.page(params[:page]).per(10)
  end

  def edit; end

  def update
    if @items.update({ approved_by: current_user.id, rejected_by: nil })
      redirect_to '/', flash: { success: 'Item Approved' }
    else
      render 'edit'
    end
  end

  def rejected
    @rejected_sellers = Product.rejected_sellers.page(params[:page]).per(10)
    @rejected_buyers = Product.rejected_buyers.page(params[:page]).per(10)
  end

  def reject_post
    if @items.update({ approved_by: nil, rejected_by: current_user.id })
      redirect_to rejected_admin_index_path, flash: { success: 'Item Rejected' }
    else
      redirect_to pending_approvals_admin_index_path, flash: { error: 'There is a problem' }
    end
  end

  private

  def find_prod
    @items = Product.find(params[:id])
  end
end
