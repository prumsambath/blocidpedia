require 'faker'

FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password 'helloworld'

    factory :standard_user do
      role 'standard'
    end

    factory :premium_user do
      role 'premium'
    end
  end
end
