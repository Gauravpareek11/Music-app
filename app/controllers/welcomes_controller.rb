class WelcomesController < ApplicationController
  def index
    @items=Product.where.not(approved_by: nil)
  end
end
