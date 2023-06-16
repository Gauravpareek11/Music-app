class RenameColumnUserInProductsTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :user, :role
  end
end
