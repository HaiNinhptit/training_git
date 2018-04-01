class ProductsController < ApplicationController
  layout :dynamic_layout

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).includes(:category)
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def add_to_cart
    if user_signed_in?
      if current_user.cart.nil?
        cart = current_user.build_cart
        cart.save
        cart.cart_products.create(product_id: params[:id])
      else
        cart_product = current_user.cart.cart_products.where(product_id: params[:id]).first
        if cart_product.nil?
          current_user.cart.cart_products.create(product_id: params[:id])
        else
          cart_product.update(quantity: cart_product.quantity + 1)
        end
      end
    else
      if session[:cart].present?
        check = 0
        session[:cart].each do |arr_cart|
          if arr_cart['product_id'].to_i.eql? params[:id].to_i
            arr_cart['quantity'] += 1
            check = 1
          end
        end
        session[:cart].insert(0, 'product_id' => params[:id], 'quantity' => 1) if check.zero?
      else
        session[:cart] = ['product_id' => params[:id], 'quantity' => 1]
      end
    end
  end

  def confirm_cart
    @cart = current_user.cart if user_signed_in?
  end

  def delete_element_session_cart
    session[:cart].each do |arr_cart|
      session[:cart].delete(arr_cart) if arr_cart['product_id'].eql? params[:id]
    end
    redirect_to confirm_cart_path
  end

  def edit_element_session_cart
    session[:cart].each do |arr_cart|
      if arr_cart['product_id'].eql? params[:id]
        arr_cart['quantity'] = update_quantity_params_session[:quantity]
      end
    end
    redirect_to confirm_cart_path
  end

  private

  def update_quantity_params_session
    params
      .permit(
        :quantity
      )
  end

  def dynamic_layout
    if user_signed_in?
      'application'
    else
      'guest'
    end
  end
end
