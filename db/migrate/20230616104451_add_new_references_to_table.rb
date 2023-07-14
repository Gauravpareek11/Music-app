# frozen_string_literal: true

# This is migration file
class AddNewReferencesToTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :sub_categories, :category, foreign_key: true
    add_reference :products, :user, foreign_key: true
    add_reference :products, :category, foreign_key: true
    add_reference :products, :sub_category, foreign_key: true
  end
end
