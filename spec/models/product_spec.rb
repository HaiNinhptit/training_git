require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_numericality_of(:price).only_integer. is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:cart_products) }
    it { should have_many(:carts) }
    it { should have_many(:order_products) }
    it { should have_many(:orders) }
    it { should belong_to(:category)}
  end
end