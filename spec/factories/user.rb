FactoryGirl.define do
  factory :user do
    name        { Faker::Name.name }
    email       { Faker::Internet.email }
    password    { Faker::Internet.password }
    avatar      { File.open(Rails.root.join('spec', 'support', 'avatar', 'avatar.jpg')) }
  end
end