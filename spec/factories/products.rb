# frozen_string_literal: true

# This is products_factory
FactoryBot.define do
  factory :product do
    title { 'Example Title' }
    description { 'Example Description must be 30 Characters asdfghj' }
    phone_number { '12345678' }
    user_name { 'Example User' }
    price { 10.99 }
    location { 'Example Location' }
    role { 'Seller' }
    association :user
    association :category
    association :sub_category

    after(:build) do |product|
      product.category = Category.first || create(:category, items: 'test_item')
      product.sub_category = Category.first.sub_categories.first || create(:sub_category, category: product.category)
    end
  end
end
