# frozen_string_literal:true

# This is reviews test file
require 'rails_helper'

RSpec.describe Review, type: :model do
  review = FactoryBot.build(:review)
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(review).to be_valid
    end
    it 'is valid with a rating' do
      review.rating = 5
      expect(review).to be_valid
    end
    it 'is valid without a comment' do
      review.comment = nil
      expect(review).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'belongs_to product' do
      association = described_class.reflect_on_association(:product)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
