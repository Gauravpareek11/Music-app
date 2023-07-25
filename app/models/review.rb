# frozen_string_literal: true

# This is Product Model
class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
end
