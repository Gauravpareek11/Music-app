# frozen_string_literal: true

# This is Reviews Controller
class ReviewsController < ApplicationController
  before_action :find_product
  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: 'Review created successfully.'
    else
      render 'products/show'
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
