# == Schema Information
#
# Table name: cart_products
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quantity   :integer
#

require 'test_helper'

class CartProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
