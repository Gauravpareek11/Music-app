# frozen_string_literal: true

# This is user_factory
FactoryBot.define do
  factory :user do
    name { 'Gaurav' }
    email { 'GAURAVPareek@example.com' }
    password_digest { 'password_digest' }
  end
end
