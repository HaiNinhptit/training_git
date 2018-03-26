FactoryGirl.define do
  factory :order_product do
    user_id       1
    product_id    1
    quantity      {Faker::Number.number(1)}
  end
end