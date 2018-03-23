class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :add_to_cart, :confirm_cart, :delete_element_session_cart, :edit_element_session_cart]
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
          if arr_cart['product_id'].eql? params[:id]
            arr_cart['quantity'] += 1
            check = 1
          end
        end
        session[:cart].insert(0, *['product_id' => params[:id], 'quantity' => 1]) if check.zero?
      else
        session[:cart] = ['product_id' => params[:id], 'quantity' => 1]
      end
    end
  end

  def confirm_cart
    if user_signed_in?
      @cart = current_user.cart
    end
  end

  def delete_element_session_cart
    session[:cart].each do |arr_cart|
      if arr_cart['product_id'].eql? params[:id]
        session[:cart].delete(arr_cart)
      end
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
end
