require 'rails_helper'

RSpec.describe CartProductsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:product1) do
    FactoryGirl.build(:product).tap do |create_product|
      create_product.user_id = user.id
      create_product.save
    end
  end
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

  describe 'PATCH# edit' do
    it do
      cart_product1.update_attributes(quantity: 1)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      patch :edit, params: { id: cart_product1.id, cart_product: { quantity: 5 } }
      expect(cart_product1.reload.quantity).to eq 5
    end
  end

  describe 'DELETE# destroy' do
    it do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user2
      delete :destroy, params: { id: cart_product1.id }
      expect(response).to redirect_to(confirm_cart_path)
    end
  end
end
