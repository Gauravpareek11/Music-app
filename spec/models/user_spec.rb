# frozen_string_literal: true

# This is User_Spec
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user = FactoryBot.build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      FactoryBot.create(:user, email: 'john@example.com')
      user = FactoryBot.build(:user, email: 'john@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password_digest' do
      user = FactoryBot.build(:user, password_digest: nil)
      expect(user).not_to be_valid
    end
  end
  describe '#downcase_email' do
    it 'downcases the email' do
      user = FactoryBot.build(:user, email: 'jOHN@EXAMPLE.COM')
      user.email=user.downcase_email
      expect(user.email).to eq('john@example.com')
    end
  end
end
