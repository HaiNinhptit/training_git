# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ApplicationRecord
  belongs_to :user

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  def self.revenue_in_day
    revenue = 0
    where(created_at: Time.zone.today.to_s.to_date).find_each do |order|
      order.order_products.each do |order_product|
        revenue += order_product.product.price * order_product.quantity
      end
    end
    revenue
  end
end
