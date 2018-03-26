class CartProductsController < ApplicationController
  def edit
    CartProduct.find_by(id: params[:id]).update(quantity: update_quantity_params[:quantity])
  end

  def destroy
    CartProduct.find_by(id: params[:id]).destroy
    redirect_to confirm_cart_path
  end

  private

  def update_quantity_params
    params.require(:cart_product)
          .permit(
            :quantity
          )
  end
end
