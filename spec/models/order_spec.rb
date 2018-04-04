# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should have_many(:order_products).dependent(:destroy) }
    it { should have_many(:products) }
    it { should belong_to(:user) }
  end

  let!(:user) { FactoryGirl.create :user }
  let!(:user1) { FactoryGirl.create :user }
  let!(:product) do
    FactoryGirl.build(:product).tap do |create_product|
      create_product.user_id = user1.id
      create_product.price = 1000
      create_product.save
    end
  end
  let!(:order) do
    FactoryGirl.build(:order).tap do |create_order|
      create_order.user_id = user.id
      create_order.created_at = Time.zone.today.to_s.to_date
      create_order.save
    end
  end

  # def self.revenue_in_day
  #   revenue = 0
  #   Order.where(created_at: Time.zone.today.to_s.to_date).each do |order|
  #     order.order_products.each do |order_product|
  #       revenue += order_product.product.price * order_product.quantity
  #     end
  #   end
  #   revenue
  # end
  describe '#self.revenue_in_day' do
    it do
      expect(Order.revenue_in_day)
    end
  end
end
