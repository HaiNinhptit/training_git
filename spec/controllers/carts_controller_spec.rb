require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
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

  describe 'GET# index' do
    it do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user1
      get :index
      expect(response).to have_http_status(:success)
    end

    it do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
