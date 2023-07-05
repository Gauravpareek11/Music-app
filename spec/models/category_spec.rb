# frozen_string_literal: true

# This is category_Spec
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      cat = FactoryBot.build(:category)
      expect(cat).to be_valid
    end

    it 'is not valid without a body' do
      cat = FactoryBot.build(:category)
      cat.items = nil
      expect(cat).not_to be_valid
    end
  end
end
