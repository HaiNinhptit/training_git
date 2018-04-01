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
#  image       :string(255)
#  user_id     :integer
#

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :cart_products
  has_many :carts, through: :cart_products
  has_many :order_products
  has_many :orders, through: :order_products
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: %i(create update)
  mount_uploader :image, ImageUploader
  validates :image, allow_blank: true, format: { with: /.(gif|jpg|png)\Z/i, message: 'must be a URL for GIF, JPG or PNG image.' }
end
