require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:product) { FactoryGirl.create :product, user_id: user.id }
  let!(:product1) { FactoryGirl.create :product, user_id: user.id }
  let!(:user1) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user }
  let!(:cart1) { FactoryGirl.create :cart, user_id: user2.id }
  let!(:cart_product1) { FactoryGirl.create :cart_product, cart_id: cart1.id, product_id: product1.id }

  describe 'GET #index' do
    it do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'return product' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'POST #add_to_cart' do
    it 'user_sign_in and cart of current_user nil' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user1
      post :add_to_cart, params: { id: product.id }
      expect(Cart.last.user_id).to eq user1.id
      expect(CartProduct.last.product_id).to eq product.id
    end

    it 'user_sign_in and user have cart and cart_product nil' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      post :add_to_cart, params: { id: product.id }
      expect(CartProduct.last.product_id).to eq product.id
    end

    it 'user_sign_in and user have cart and cart_product' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      cart_product1.update(quantity: 1)
      post :add_to_cart, params: { id: product1.id }
      expect(cart_product1.reload.quantity).to eq 2
    end

    it 'user not sign_in ' do
      post :add_to_cart, params: { id: product.id }
      expect(session[:cart]).to eq(['product_id' => product.id.to_s, 'quantity' => 1])
    end

    it 'user not sign_in and  ' do
      session[:cart] = [{ 'product_id' => product.id.to_s, 'quantity' => 1 }]
      post :add_to_cart, params: { id: product1.id }
      expect(session[:cart]).to eq([{ 'product_id' => product1.id.to_s, 'quantity' => 1 }, { 'product_id' => product.id.to_s, 'quantity' => 1 }])
    end

    it 'user not sign_in and not found product_id in session[:cart] ' do
      session[:cart] = [{ 'product_id' => product.id.to_s, 'quantity' => 1 }]
      post :add_to_cart, params: { id: product1.id }
      expect(session[:cart]).to eq([{ 'product_id' => product1.id.to_s, 'quantity' => 1 }, { 'product_id' => product.id.to_s, 'quantity' => 1 }])
    end

    it 'user not sign_in and found product_id in session[:cart] ' do
      session[:cart] = [{ 'product_id' => product.id.to_s, 'quantity' => 1 }]
      post :add_to_cart, params: { id: product.id }
      expect(session[:cart]).to eq([{ 'product_id' => product.id.to_s, 'quantity' => 2 }])
    end
  end

  describe 'GET #confirm_cart' do
    it 'return cart of user sign_in' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      get :confirm_cart
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE# delete_element_session_cart' do
    it 'delete element of session[:cart]' do
      session[:cart] = [{ 'product_id' => product.id.to_s, 'quantity' => 1 }]
      delete :delete_element_session_cart, params: { id: product.id }
      expect(session[:cart]).to eq([])
      expect(response).to redirect_to(confirm_cart_path)
    end
  end

  describe 'PATCH# edit_element_session_cart' do
    it 'edit element session cart' do
      session[:cart] = [{ 'product_id' => product.id.to_s, 'quantity' => 1 }]
      patch :edit_element_session_cart, params: { id: product.id, quantity: 5 }
      expect(session[:cart]).to eq([{ 'product_id' => product.id.to_s, 'quantity' => '5' }])
      expect(response).to redirect_to(confirm_cart_path)
    end
  end
end
