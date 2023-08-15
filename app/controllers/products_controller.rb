# frozen_string_literal: true

# This is Products Controller
class ProductsController < ApplicationController
  before_action :authorize, except: %i[search filter apply_filtering sub_categories buy sell]
  before_action :show_data
  before_action :restrict_admin, only: %i[new create]
  before_action :find_prod, only: %i[show edit update destroy]
  before_action :edit_unapproved, only: %i[edit update]
  skip_before_action :set_nil, only: %i[search filter apply_filtering sub_categories show]

  def new
    @product = Product.new
  end

  def show
    @reviews = @product.reviews.page(params[:page]).per(10)
  end

  def create
    @product = Product.new(product_params)
    @product[:user_id] = current_user.id
    if @product.save
      redirect_to root_path, flash: { success: 'Item Posted It will be public after Admin\'s Approval' }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product, flash: { success: 'Item Sucessfully Updated' }
    else
      render 'edit'
    end
  end

  def destroy
    if @product.destroy
      redirect_to items_posted_path, flash: { success: 'Item Sucessfully deleted' }
    else
      redirect_to items_posted_path, flash: { error: 'There was a problem' }
    end
  end

  def sub_categories
    item = SubCategory.where(category_id: params[:id])
    render json: item
  end

  def buy
    @items = Product.seller(current_user&.id)
    @items = apply_filtering(@items, params)
    @items = @items.page(params[:page]).per(10)
  end

  def sell
    @items = Product.buyer(current_user&.id)
    @items = apply_filtering(@items, params)
    @items = @items.page(params[:page]).per(10)
  end

  def search
    query = params[:search_posts].presence && params[:search_posts][:query]

    return unless query

    @products = Product.search_published(query.strip).records
    begin
      @products = @products.page(params[:page]).per(10)
    rescue StandardError
      @products = []
    end
    session[:item] = query
  end

  def filter
    query = session[:item]
    prod = Product.search_published(query.strip).records
    @products = apply_filtering(prod, params)
    @products = @products.page(params[:page]).per(10)
    render :search
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :sub_category_id, :category_id, :user_name, :phone_number,
                                    :price, :role, :location, :user_id, images: [])
  end

  def find_prod
    @product = Product.find(params[:id])
  end

  def edit_unapproved
    redirect_to root_path, flash: { error: 'You cannot edit approved post' } if @product.approved_by
  end
end
