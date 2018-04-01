FactoryGirl.define do
  factory :cart_product do
    cart_id       1
    product_id    1
    quantity      { Faker::Number.number(1) }
  end
end
