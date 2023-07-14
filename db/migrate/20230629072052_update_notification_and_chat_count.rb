# frozen_string_literal: true

# This is migration file
class UpdateNotificationAndChatCount < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :conversations, :users, column: :sender_id
    add_foreign_key :conversations, :users, column: :recipient_id
    add_foreign_key :notifications, :users, column: :sender_id
    add_foreign_key :notifications, :users, column: :recipient_id

    add_column :messages, :read, :boolean, default: false
    add_column :notifications, :read, :boolean, default: false
  end
end
