class SubCategoriesController < ApplicationController
  before_action :authorize
  before_action :restrict_user
  before_action :show_data
  def new
      @sub_categories=SubCategory.new
  end
  def create
    @sub_categories=SubCategory.new(sub_category_params)
    if @sub_categories.save
        redirect_to '/',flash: {success:"Item Created"}
    else
        render 'new'
    end
  end
  private
  def sub_category_params
      # binding.pry
      params.require(:sub_category).permit(:items,:category_id)
  end
end
