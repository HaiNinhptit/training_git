# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  category_id :integer
#  name        :string(255)
#  price       :integer
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_products
  has_many :carts, :through => :cart_products
  has_many :order_products
  has_many :orders, :through => :order_products
end
