# frozen_string_literal: true

# This is Welcomes Controller
class WelcomesController < ApplicationController
  before_action :show_data
  def index
    if current_user&.admin?
      @items = Product.seller.limit(8)
      @require = Product.buyer.limit(8)
    else
      @items = Product.approved_sellers(current_user&.id).limit(8)
      @require = Product.approved_buyers(current_user&.id).limit(8)
    end
  end
end
