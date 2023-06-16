class ProductsController < ApplicationController
  before_action :authorize
  def new
    @product=Product.new
end
def create
    # binding.pry
    @product=Product.new(product_params)
    @product[:user_id]=current_user.id
    if @product.save
        redirect_to '/'
    else
        render 'new'
    end
end
def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to pending_approvals_admin_index_path()
end
def sub_categories
    # binding.pry
    item=SubCategory.where(category_id: params[:id])
    render json: item
end
private 
def product_params
    params.require(:product).permit(:title,:description,:sub_category_id,:category_id,:user_name,:phone_number,:price,:role,:location,:user_id,images:[])
end
end
