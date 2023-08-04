# frozen_string_literal: true

# This is Categories Controller
class CategoriesController < ApplicationController
  before_action :authorize
  before_action :restrict_user
  before_action :show_data
  before_action :find_category, only: %i[edit update destroy]

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
      redirect_to categories_path, flash: { success: 'Category Created' }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, flash: { succes: 'Category updated successfully' }
    else
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, flash: { success: 'Item destroyed Successfully' }
    else
      redirect_to categories_path, flash: { error: 'Unable to process your request' }
    end
  end

  private

  def category_params
    params.require(:category).permit(:items)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
