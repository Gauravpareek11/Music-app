class Category < ApplicationRecord
  has_many :sub_categories,dependent: :destroy
  has_many :products
  validates :items, presence: {message:"Item can't be null"},uniqueness: {message:"Item already exist"}
end
