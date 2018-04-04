class CartProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_cart_product

  def edit
    @cat_product.update(quantity: update_quantity_params[:quantity])
  end

  def destroy
    redirect_to confirm_cart_path if @cat_product.destroy
  end

  private

  def update_quantity_params
    params.require(:cart_product)
          .permit(
            :quantity
          )
  end

  def find_cart_product
    @cat_product = CartProduct.find_by(id: params[:id])
  end
end
