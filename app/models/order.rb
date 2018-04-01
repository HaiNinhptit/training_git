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

  def self.orders_in_day
    orders = Order.where(created_at: Time.zone.today.to_s.to_date)
    array_products = []
    orders.each do |order|
      order.order_products.each do |order_product|
        check = 0
        if array_products.any?
          array_products.each do |product|
            if order_product.product_id == product['id']
              product['quantity'] += order_product.quantity
              check = 1
            end
          end
        end
        array_products.push('id' => order_product.product_id, 'quantity' => order_product.quantity) if check.zero?
      end
    end
    array_products
  end
end
