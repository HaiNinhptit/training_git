class ProductsController < ApplicationController
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
        cart = current_user.create_cart
        cart.cart_products.create(product_id: params[:id])
      else
        cart_product = current_user.cart.cart_products.find_by(product_id: params[:id])
        if cart_product.nil?
          current_user.cart.cart_products.create(product_id: params[:id])
        else
          cart_product.update(quantity: cart_product.quantity + 1)
        end
      end
    else
      get_session_cart params[:id]
    end
  end

  def confirm_cart
    @cart = current_user.cart if user_signed_in?
  end

  def delete_element_session_cart
    cart = session[:cart].detect { |c| c['product_id'].eql? params[:id] }
    session[:cart].delete(cart) if cart.present?
    redirect_to confirm_cart_path
  end

  def edit_element_session_cart
    session[:cart].each do |arr_cart|
      arr_cart['quantity'] = params[:quantity] if arr_cart['product_id'].eql? params[:id]
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

  def get_session_cart(id)
    if session[:cart].present?
      if session[:cart].detect { |p| p['product_id'].to_i.eql? id.to_i }.nil?
        session[:cart].insert(0, 'product_id' => id, 'quantity' => 1)
      else
        session[:cart].each do |arr_cart|
          arr_cart['quantity'] += 1 if arr_cart['product_id'].to_i.eql? id.to_i
        end
      end
    else
      session[:cart] = ['product_id' => id, 'quantity' => 1]
    end
  end
end
