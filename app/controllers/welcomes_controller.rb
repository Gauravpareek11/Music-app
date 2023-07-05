# frozen_string_literal: true

# This is Welcomes Controller
class WelcomesController < ApplicationController
  before_action :show_data
  def index
    @items = Product.where.not(approved_by: nil).where(role: 'Seller')
    @require = Product.where.not(approved_by: nil).where(role: 'Buyer')
  end
end
