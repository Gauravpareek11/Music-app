# frozen_string_literal: true

# This is message_factory
FactoryBot.define do
  factory :message do
    body {'hi'}
    association :conversation
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
