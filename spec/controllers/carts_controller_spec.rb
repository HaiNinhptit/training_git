require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:product1) { FactoryGirl.create :product, user_id: user.id }
  let!(:user1) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user }
  let!(:cart1) { FactoryGirl.create :cart, user_id: user2.id }
  let!(:cart_product1) { FactoryGirl.create :cart_product, cart_id: cart1.id, product_id: product1.id }

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
