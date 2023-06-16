class RemoveReferencesInTable < ActiveRecord::Migration[6.1]
  def change
    remove_reference :sub_categories, :categories,index: true, foreign_key: true
    remove_reference :products, :users,index: true,foreign_key: true
    remove_reference :products, :categories,index: true,foreign_key: true
    remove_reference :products, :sub_categories,index: true,foreign_key: true
  end
end
