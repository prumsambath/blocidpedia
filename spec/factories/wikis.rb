require 'faker'

FactoryGirl.define do
  factory :wiki do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    private false
    user

    factory :private_wiki do
      private true
    end
  end

  factory :invalid_wiki, class: Wiki do
    title ''
    body ''
    user
  end
end
