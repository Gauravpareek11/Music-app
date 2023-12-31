# frozen_string_literal: true

# This is SubCategory Model
class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy

  validates :items, uniqueness: { scope: :category_id, message: 'item already exist for given category' },
                    presence: { message: 'Item can\'t be null' }
end
