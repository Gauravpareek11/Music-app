class Category < ApplicationRecord
  has_many :sub_category,dependent: :destroy
end
