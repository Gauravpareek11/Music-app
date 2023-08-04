# frozen_string_literal: true

# This is Products Controller
class ProductsController < ApplicationController
  before_action :authorize, except: %i[search filter apply_filtering sub_categories]
  before_action :show_data
  before_action :restrict_admin, only: %i[new create]
  skip_before_action :set_nil, only: %i[search filter apply_filtering sub_categories show]

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page]).per(10)
  end

  def create
    @product = Product.new(product_params)
    @product[:user_id] = current_user.id
    if @product.save
      redirect_to '/', flash: { success: 'Item Posted It will be public after Admin\'s Approval' }
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, flash: { success: 'Item Sucessfully Updated' }
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to items_posted_path, flash: { success: 'Item Sucessfully deleted' }
    else
      redirect_to items_posted_path, flash: { success: 'There was a problem' }
    end
  end

  def sub_categories
    item = SubCategory.where(category_id: params[:id])
    render json: item
  end

  def buy
    @items = current_user&.admin? ? Product.seller : Product.approved_sellers(current_user&.id)
    @items = @items.page(params[:page]).per(10)
  end

  def sell
    @items = current_user&.admin? ? Product.buyer : Product.approved_buyers(current_user&.id)
    @items = @items.page(params[:page]).per(10)
  end

  def search
    query = params[:search_posts].presence && params[:search_posts][:query]

    return unless query

    @products = Product.search_published(query.strip).records
    @products = @products.page(params[:page]).per(10)
    session[:item] = query
  end

  def filter
    query = session[:item]
    prod = Product.search_published(query.strip).records
    @products = apply_filtering(prod, params)
    @products = @products.page(params[:page]).per(10)
    render :search
  end

  def apply_filtering(prod, params)
    prod = prod.where(category_id: params[:category]) if params[:category].present?
    prod = prod.where(sub_category_id: params[:sub_category]) if params[:sub_category].present?
    prod = prod.where('location ilike ?', "%#{params[:location]}%") if params[:location].present?
    prod
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :sub_category_id, :category_id, :user_name, :phone_number,
                                    :price, :role, :location, :user_id, images: [])
  end
end
