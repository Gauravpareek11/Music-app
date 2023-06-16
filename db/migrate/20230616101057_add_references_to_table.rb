class AddReferencesToTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :sub_categories, :categories, foreign_key: true
    add_reference :products, :users,foreign_key: true
    add_reference :products, :categories,foreign_key: true
    add_reference :products, :sub_categories,foreign_key: true
  end
end
