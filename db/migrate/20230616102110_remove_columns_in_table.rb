# frozen_string_literal: true

# This is migration file
class RemoveColumnsInTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :user_id
    remove_column :products, :category_id
    remove_column :products, :sub_category_id
    remove_column :sub_categories, :category_id
  end
end
