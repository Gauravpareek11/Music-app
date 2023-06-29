class AdminController < ApplicationController
  before_action :show_data
  def index
  end
  def pending_approvals
    @items=Product.where(approved_by: nil)
  end
  def edit
    @items=Product.find(params[:id])
  end
  def update
    @items=Product.find(params[:id])
    # @items[:approved_by]=current_user.id
    if @items.update({approved_by: current_user.id})
      redirect_to '/' ,flash:{success:"Item Approved"}
    else 
      render 'edit'
    end
  end
  private
  # def approval_params
  #   binding.pry
  #   params.require(:product).permit(:approved_by)
  # end
end
