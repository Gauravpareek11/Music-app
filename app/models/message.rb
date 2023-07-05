# frozen_string_literal: true

# This is Message Model
class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates_presence_of :body
end
