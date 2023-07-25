# frozen_string_literal: true

# This is User Model
class User < ApplicationRecord
  require 'securerandom'
  before_create :downcase_email

  has_secure_password

  has_many :products, dependent: :destroy
  has_many :approved_products, class_name: 'Product', foreign_key: :approved_by
  has_many :rejected_products, class_name: 'Product', foreign_key: :rejected_by
  has_many :reviews
  has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'recipient_id'
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id'
  has_many :received_notifications, class_name: 'Notification', foreign_key: 'recipient_id'

  validates :name, presence: { message: 'Name Can\'t be empty' }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid Email' },
                    uniqueness: { message: 'Already exist', case_sensitive: false },
                    presence: { message: 'Email can\'t be empty' }
  validates :password_digest, presence: { message: 'Password Can\'t be empty' }

  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email)
    user ||= User.create(
      name: auth.info.name,
      email: auth.info.email,
      password: SecureRandom.alphanumeric(10) # Generate a random password of length 10
    )
    user
  end

  def downcase_email
    self.email = email.downcase
  end
end
