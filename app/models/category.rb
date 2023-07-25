# frozen_string_literal: true

# This is Category Model
class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :items, presence: { message: 'Item can\'t be null' }, uniqueness: { message: 'Item already exist' }
end
