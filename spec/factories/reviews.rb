# frozen_string_literal: true

# This is Reviews_factory
FactoryBot.define do
  factory :review do
    rating { 1 }
    comment { 'MyText' }
    user
    product
  end
end
