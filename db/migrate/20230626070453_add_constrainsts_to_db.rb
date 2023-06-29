class AddConstrainstsToDb < ActiveRecord::Migration[6.1]
  def change
    add_column :users,:name,:string,null: false,default: "name"
    change_column :users, :email, :string, null: false,unique: true
    change_column :users, :password_digest, :string, null: false
    remove_column :users, :password_confirmation

    change_column :products, :title, :string, null: false
    change_column :products, :description, :string, null: false
    change_column :products, :phone_number, :string, null: false
    change_column :products, :price, :string, null: false
    change_column :products, :user_name, :string, null: false
    change_column :products, :location, :string, null: false

    rename_column :categories, :products, :items
    change_column :categories, :items, :string, null: false,unique: true

    add_index :sub_categories, [:items, :category_id], unique: true

    add_foreign_key :messages, :conversations, column: :conversation_id
  end
end
