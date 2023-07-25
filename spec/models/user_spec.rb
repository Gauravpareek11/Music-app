# frozen_string_literal: true

# This is User_Spec
require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.describe User, type: :model do
  user = FactoryBot.build(:user)
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user.email = 'invalid email'
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      FactoryBot.create(:user, email: 'john@example.com')
      user = FactoryBot.build(:user, email: 'john@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password_digest' do
      user.password_digest = nil
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many products with dependent destroy' do
      association = described_class.reflect_on_association(:products)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many reviews' do
      association = described_class.reflect_on_association(:reviews)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many sent conversations' do
      association = described_class.reflect_on_association(:sent_conversations)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Conversation')
      expect(association.options[:foreign_key]).to eq('sender_id')
    end

    it 'has many received conversations' do
      association = described_class.reflect_on_association(:received_conversations)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Conversation')
      expect(association.options[:foreign_key]).to eq('recipient_id')
    end

    it 'has many sent notifications' do
      association = described_class.reflect_on_association(:sent_notifications)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Notification')
      expect(association.options[:foreign_key]).to eq('sender_id')
    end

    it 'has many received notifications' do
      association = described_class.reflect_on_association(:received_notifications)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Notification')
      expect(association.options[:foreign_key]).to eq('recipient_id')
    end
  end

  describe '#downcase_email' do
    it 'downcases the email' do
      user = FactoryBot.build(:user, email: 'jOHN@EXAMPLE.COM')
      user.email = user.downcase_email
      expect(user.email).to eq('john@example.com')
    end
  end

  describe 'self.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'provider_name',
        uid: '123456',
        info: {
          name: 'John Doe',
          email: 'john.doe@example.com'
        }
      )
    end

    context 'when user already exists' do
      it 'returns the existing user' do
        existing_user = User.create(name: 'John Doe', email: 'john.doe@example.com')
        user = User.from_omniauth(auth)
        expect(user.name).to eq(existing_user.name)
        expect(user.email).to eq(existing_user.email)
      end
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        user = User.from_omniauth(auth)
        expect(user.name).to eq('John Doe')
        expect(user.email).to eq('john.doe@example.com')
        expect(user).to be_a(User)
        expect(user).to be_persisted
      end

      it 'generates a random password for the new user' do
        user = User.from_omniauth(auth)
        expect(user.password).not_to be_nil
        expect(user.password.length).to eq(10)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
