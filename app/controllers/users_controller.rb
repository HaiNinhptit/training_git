class UsersController < ApplicationController
  before_action :authenticate_user!

  def order
    if params[:id].present?
      @cart = Cart.find_by(id: params[:id])
    else
      if current_user.cart.present?
        session[:cart].each do |arr_cart|
          check = 0
          current_user.cart.cart_products.each do |product_cart|
            if arr_cart['product_id'].to_i.eql? product_cart.product_id
              product_cart.update(quantity: product_cart.quantity + arr_cart['quantity'])
              check = 1
            end
          end
          current_user.cart.cart_products.create(product_id: arr_cart['product_id'], quantity: arr_cart['quantity']) if check.zero?
        end
      else
        cart = current_user.build_cart
        cart.save
        session[:cart].each do |arr_cart|
          cart.cart_products.create(product_id: arr_cart['product_id'], quantity: arr_cart['quantity'])
        end
      end
      @cart = current_user.cart
    end
    session.delete(:cart)
  end

  def order_confirm
      @cart = Cart.find_by(id: params[:id])
      order = current_user.orders.build()
      order.save
      @cart.cart_products.each do |cart_product|
        order.order_products.create(product_id: cart_product.product_id, quantity: cart_product.quantity)
      end
      @cart.destroy
      OrderConfirmationMailer.order_confirmation(current_user, order).deliver
  end
end