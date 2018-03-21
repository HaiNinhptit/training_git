class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).includes(:category)
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def add_to_cart
  end
end
