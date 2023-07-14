# frozen_string_literal: true

# This is Categories Controller
class CategoriesController < ApplicationController
  before_action :authorize
  before_action :restrict_user
  before_action :show_data
  def index
    @category = Category.all
    @category = @category.page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to '/', flash: { success: 'Item Created' }
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to '/admin'
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to '/admin', flash: { success: 'Item destroyed Successfully' }
    else
      redirect_to admin_categories_path, flash: { error: 'Unable to process your request' }
    end
  end

  private

  def category_params
    params.require(:category).permit(:items)
  end
end
