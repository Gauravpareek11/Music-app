# frozen_string_literal: true

# This is user_factory
FactoryBot.define do
  factory :user do
    name { 'Gaurav' }
    email { 'GAURAV@example.com' }
    password_digest { 'password_digest' }
  end
end
