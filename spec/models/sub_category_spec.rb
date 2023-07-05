# frozen_string_literal: true

# This is sub_category_Spec
require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  describe 'validations' do
    # subject { build(:sub_category) }

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
end
