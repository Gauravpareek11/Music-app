# frozen_string_literal: true

# This is notifications_factory
FactoryBot.define do
  factory :notification do
    body { { name: 'Gaurav', email: 'gaurav@gmail.com' } }
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
