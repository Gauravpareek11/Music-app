# frozen_string_literal: true

# This is migration file
class RemoveDefaultNameFromUsersTable < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :name, nil
  end
end
