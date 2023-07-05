# frozen_string_literal: true

# This is Products Controller
class ProductsController < ApplicationController
  before_action :authorize, except: :search
  before_action :show_data
  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    @product[:user_id] = current_user.id
    if @product.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to pending_approvals_admin_index_path
  end

  def sub_categories
    item = SubCategory.where(category_id: params[:id])
    render json: item
  end

  def buy
    @items = Product.where.not(approved_by: nil).where(role: 'Seller')
  end

  def search
    query = params[:search_posts].presence && params[:search_posts][:query]

    return unless query

    @products = Product.search_published(query)
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :sub_category_id, :category_id, :user_name, :phone_number,
                                    :price, :role, :location, :user_id, images: [])
  end
end
