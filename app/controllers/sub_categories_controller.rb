# frozen_string_literal: true

# This is SubCategoriesController Controller
class SubCategoriesController < ApplicationController
  before_action :authorize
  before_action :restrict_user
  before_action :show_data
  def index
    @sub_categories = SubCategory.all
    @sub_categories = @sub_categories.page(params[:page]).per(10)
  end

  def new
    @sub_categories = SubCategory.new
  end

  def create
    @sub_categories = SubCategory.new(sub_category_params)
    if @sub_categories.save
      redirect_to '/', flash: { success: 'Item Created' }
    else
      render 'new'
    end
  end

  def edit
    @sub_categories = SubCategory.find(params[:id])
  end

  def update
    @sub_categories = SubCategory.find(params[:id])
    if @sub_categories.update(sub_category_params)
      redirect_to '/admin'
    else
      render 'edit'
    end
  end

  def destroy
    @sub_categories = SubCategory.find(params[:id])
    if @sub_categories.destroy
      redirect_to '/admin', flash: { success: 'Item destroyed Successfully' }
    else
      redirect_to admin_categories_path, flash: { error: 'Unable to process your request' }
    end
  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:items, :category_id)
  end
end
