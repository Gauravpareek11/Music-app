# frozen_string_literal: true

# This is migration file
class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :products
      t.timestamps
    end
  end
end
