require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:product) do
    FactoryGirl.build(:product).tap do |create_product|
      create_product.user_id = user.id
      create_product.save
    end
  end
  let!(:product1) do
    FactoryGirl.build(:product).tap do |create_product|
      create_product.user_id = user.id
      create_product.save
    end
  end
  let!(:user1) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user }
  let!(:cart1) do
    FactoryGirl.build(:cart).tap do |create_cart|
      create_cart.user_id = user2.id
      create_cart.save
    end
  end
  let!(:cart_product1) do
    FactoryGirl.build(:cart_product).tap do |create_cart_product|
      create_cart_product.cart_id = cart1.id
      create_cart_product.product_id = product1.id
      create_cart_product.save
    end
  end
  let!(:category) { FactoryGirl.create :category }

  describe 'GET #order' do
    it 'user add to cart when user logged in' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      get :order, params: { id: cart1.id }
      expect(assigns(:cart)).to eq(cart1)
    end

    it 'user add to cart when user not loggin and not find product in session in cart' do
      session[:cart] = [{ 'product_id' => product.id.to_s, 'quantity' => 1 }]
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      get :order
      expect(CartProduct.last.cart_id).to eq(cart1.id)
    end

    it 'user add to cart when user not loggin and find product in session in cart ' do
      cart_product1.update_attributes(quantity: 1)
      session[:cart] = [{ 'product_id' => product1.id.to_s, 'quantity' => 1 }]
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      get :order
      expect(cart_product1.reload.quantity).to eq(2)
    end

    it 'user add to cart when user not loggin and not find cart' do
      session[:cart] = [{ 'product_id' => product1.id.to_s, 'quantity' => 1 }]
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user1
      get :order
      expect(Cart.last.user_id).to eq(user1.id)
      expect(CartProduct.last.product_id).to eq(product1.id)
    end
  end

  describe 'POST# order_confirm' do
    it 'create order when request params[:id] valid' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      post :order_confirm, params: { id: cart1.id }
      expect(Order.last.user_id).to eq user2.id
      expect(OrderProduct.last.product_id).to eq product1.id
    end
  end

  describe 'GET# user_post_product_for_sale' do
    it do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      get :user_post_product_for_sale
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST# user_create_product' do
    it 'create product success' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      post :user_create_product, params: { product: { name: 'aaa', category_id: category.id, description: 'aaa', image: [fixture_file_upload(Rails.root.join('spec', 'support', 'avatar', 'avatar.jpg'))], price: 123 } }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET# profile' do
    it do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      get :profile
    end
  end

  describe 'GET# get_products_of_user' do
    it do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
      get :get_products_of_user
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET# get_users_bought_your_product' do
    it do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
      get :get_users_bought_your_product
      expect(response).to have_http_status(:success)
    end
  end
end
