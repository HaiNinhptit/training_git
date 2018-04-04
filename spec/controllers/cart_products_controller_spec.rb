require 'rails_helper'

RSpec.describe CartProductsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:product1) { FactoryGirl.create :product, user_id: user.id }
  let!(:user2) { FactoryGirl.create :user }
  let!(:cart1) { FactoryGirl.create :cart, user_id: user2.id }
  let!(:cart_product1) { FactoryGirl.create :cart_product, cart_id: cart1.id, product_id: product1.id }

  describe 'PATCH# edit' do
    it do
      cart_product1.update(quantity: 1)
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
