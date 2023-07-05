# frozen_string_literal: true

# This is product_Spec
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = FactoryBot.build(:product)
      expect(product).to be_valid
    end

    it 'is not valid without a title' do
      product = FactoryBot.build(:product)
      product.title = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a description' do
      product = FactoryBot.build(:product)
      product.description = nil
      expect(product).not_to be_valid
    end

    it 'is not valid with an invalid phone number length' do
      product = FactoryBot.build(:product)
      product.phone_number = '123'
      expect(product).not_to be_valid
    end

    it 'is not valid without a phone number' do
      product = FactoryBot.build(:product)
      product.phone_number = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a user name' do
      product = FactoryBot.build(:product)
      product.user_name = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a price' do
      product = FactoryBot.build(:product)
      product.price = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a location' do
      product = FactoryBot.build(:product)
      product.location = nil
      expect(product).not_to be_valid
    end
  end
end
