# frozen_string_literal: true

# This is Welcomes Controller
class WelcomesController < ApplicationController
  before_action :show_data

  def index
    if current_user&.admin?
      load_admin_items
    else
      load_user_items
    end
  end

  private

  def load_admin_items
    @items = Product.seller(current_user&.id).limit(8)
    @require = Product.buyer(current_user&.id).limit(8)
  end

  def load_user_items
    @items = Product.approved_sellers(current_user&.id).limit(8)
    @require = Product.approved_buyers(current_user&.id).limit(8)
  end
end
