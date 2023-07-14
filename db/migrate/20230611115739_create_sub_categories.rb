# frozen_string_literal: true

# This is migration file
class CreateSubCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_categories do |t|
      t.string :items
      t.integer :category_id
      t.timestamps
    end
  end
end
