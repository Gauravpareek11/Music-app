# frozen_string_literal: true

# This is conversation_factory
FactoryBot.define do
  factory :conversation do
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
