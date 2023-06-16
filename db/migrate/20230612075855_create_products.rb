class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :category_id
      t.integer :sub_category_id
      t.string :description
      t.string :user_name
      t.string :phone_number
      t.string :price
      t.string :user
      t.string :location
      t.json :images
      t.integer :approved_by, default: nil
      t.string :rating , default: nil
      t.integer :user_id
      t.timestamps
    end
  end
end
