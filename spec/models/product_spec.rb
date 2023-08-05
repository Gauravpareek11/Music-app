# frozen_string_literal: true

# This is product_Spec
require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Product, type: :model do
  describe 'validations' do
    product = FactoryBot.build(:product)
    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a title' do
      product.title = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a description' do
      product.description = nil
      expect(product).not_to be_valid
    end

    it 'is not valid with an invalid phone number length' do
      product.phone_number = '123'
      expect(product).not_to be_valid
    end

    it 'is not valid when phone_number have special character ' do
      product.phone_number = '1235678&'
      expect(product).not_to be_valid
    end

    it 'is not valid when phone_number have special character except + in starting' do
      product.phone_number = '-1235678'
      expect(product).not_to be_valid
    end

    it 'is not valid without a phone number' do
      product.phone_number = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a user name' do
      product.user_name = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a price' do
      product.price = nil
      expect(product).not_to be_valid
    end

    it 'is invalid when price is zero' do
      product.price = 0
      expect(product).not_to be_valid
    end

    it 'is invalid when price is negative' do
      product.price = -100
      expect(product).not_to be_valid
    end

    it 'is invalid when price is not a number' do
      product.price = 'abc'
      expect(product).not_to be_valid
    end

    it 'is invalid when price contains special characters' do
      product.price = '$99.99'
      expect(product).not_to be_valid
    end

    it 'is not valid without a location' do
      product.location = nil
      expect(product).not_to be_valid
    end
  end
  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to category' do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to sub_category' do
      association = described_class.reflect_on_association(:sub_category)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many reviews' do
      association = described_class.reflect_on_association(:reviews)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many attached images' do
      association = described_class.reflect_on_association(:images_attachments)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'scopes' do
    user = FactoryBot.build(:user)
    it 'returns approved sellers except current user' do
      approved_sellers_except_current_user = Product.where.not(user_id: user.id)
                                                    .where(approved_by: 'admin', rejected_by: nil, role: 'Seller')

      expect(Product.approved_sellers(user.id)).to match_array(approved_sellers_except_current_user)
    end

    it 'returns approved buyers except current user' do
      approved_buyers_except_current_user = Product.where.not(user_id: user.id)
                                                   .where(approved_by: 'admin', rejected_by: nil, role: 'Buyer')

      expect(Product.approved_buyers(user.id)).to match_array(approved_buyers_except_current_user)
    end

    it 'returns unapproved sellers' do
      unapproved_sellers = Product.where(approved_by: nil, rejected_by: nil, role: 'Seller')

      expect(Product.unapproved_sellers).to match_array(unapproved_sellers)
    end

    it 'returns unapproved buyers' do
      unapproved_buyers = Product.where(approved_by: nil, rejected_by: nil, role: 'Buyer')

      expect(Product.unapproved_buyers).to match_array(unapproved_buyers)
    end

    it 'returns unapproved posts' do
      unapproved_posts = Product.where(approved_by: nil, rejected_by: nil)

      expect(Product.unapproved_posts).to match_array(unapproved_posts)
    end

    it 'returns rejected sellers' do
      rejected_sellers = Product.where(approved_by: nil, role: 'Seller').where.not(rejected_by: nil)

      expect(Product.rejected_sellers).to match_array(rejected_sellers)
    end

    it 'returns rejected buyers' do
      rejected_buyers = Product.where(approved_by: nil, role: 'Buyer').where.not(rejected_by: nil)

      expect(Product.rejected_buyers).to match_array(rejected_buyers)
    end

    it 'returns sellers' do
      sellers = Product.where(role: 'Seller', rejected_by: nil)

      expect(Product.seller).to match_array(sellers)
    end

    it 'returns buyers' do
      buyers = Product.where(role: 'Buyer', rejected_by: nil)

      expect(Product.buyer).to match_array(buyers)
    end
  end
end
# rubocop:enable Metrics/BlockLength
