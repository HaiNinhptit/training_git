require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should have_many(:order_products).dependent(:destroy) }
    it { should have_many(:products) }
    it { should belong_to(:user) }
  end
end