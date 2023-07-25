# frozen_string_literal: true

# This is migration
class AddColumnToProductsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :rejected_by, :integer, default: nil
  end
end
