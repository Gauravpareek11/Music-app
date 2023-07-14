# frozen_string_literal: true

# This is migration file
class RemoveColumnRatingFromProductsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :rating
  end
end
