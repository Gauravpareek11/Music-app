# frozen_string_literal: true

# This is sub_category_Spec
require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe SubCategory, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      item = FactoryBot.build(:sub_category)
      expect(item).to be_valid
    end

    it 'is not valid without a name' do
      item = FactoryBot.build(:sub_category, items: nil)
      expect(item).not_to be_valid
    end

    it 'is not valid with a duplicate item for the same category' do
      existing_item = FactoryBot.build(:sub_category, category_id: 1)
      item = FactoryBot.build(:sub_category)
      item.category = existing_item.category
      expect(item).not_to be_valid
    end
  end
  describe 'associations' do
    it 'has many products with dependent destroy' do
      association = described_class.reflect_on_association(:products)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'belongs_to category' do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
# rubocop:enable Metrics/BlockLength
