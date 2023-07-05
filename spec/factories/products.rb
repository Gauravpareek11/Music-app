# frozen_string_literal: true

# This is products_factory
FactoryBot.define do
  factory :product do
    title { "Example Title" }
    description { "Example Description" }
    phone_number { "12345678" }
    user_name { "Example User" }
    price { 10.99 }
    location { "Example Location" }
    user
    category
    sub_category
  end
end
