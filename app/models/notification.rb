# frozen_string_literal: true

# This is Notification Model
class Notification < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
