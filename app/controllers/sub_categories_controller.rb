# frozen_string_literal: true

# This is SubCategoriesController Controller
class SubCategoriesController < ApplicationController
  before_action :authorize
  before_action :restrict_user
  before_action :show_data
  before_action :find_sub_category, only: %i[edit update destroy]

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
      redirect_to sub_categories_path, flash: { success: 'SubCategory Created Sucessfully' }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @sub_categories.update(sub_category_params)
      redirect_to sub_categories_path, flash: { success: 'Item updated Successfully' }
    else
      render 'edit'
    end
  end

  def destroy
    if @sub_categories.destroy
      redirect_to sub_categories_path, flash: { success: 'Item destroyed Successfully' }
    else
      redirect_to categories_path, flash: { error: 'Unable to process your request' }
    end
  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:items, :category_id)
  end

  def find_sub_category
    @sub_categories = SubCategory.find(params[:id])
  end
end
