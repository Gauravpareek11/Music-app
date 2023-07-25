# frozen_string_literal: true

# This is category_Spec
require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Category, type: :model do
  describe 'validations' do
    cat = FactoryBot.build(:category)
    it 'is valid with valid attributes' do
      expect(cat).to be_valid
    end

    it 'is not valid without a body' do
      cat.items = nil
      expect(cat).not_to be_valid
    end

    it 'is not valid with duplicate item' do
      FactoryBot.create(:category, items: 'Item')
      cat = FactoryBot.build(:category, items: 'Item')
      expect(cat).not_to be_valid
    end
  end
  describe 'associations' do
    it 'has many products with dependent destroy' do
      association = described_class.reflect_on_association(:products)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
    it 'has many sub_categories with dependent destroy' do
      association = described_class.reflect_on_association(:sub_categories)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end
# rubocop: enable Metrics/BlockLength
