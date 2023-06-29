require 'securerandom'
class User < ApplicationRecord
  before_create :downcase_email
  # attr_accessor :password_confirmation

  # validate :passwords_match
  validates :name, presence: { message: "Name Can't be empty" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid Email' },
                  uniqueness: { message: 'Already exist', case_sensitive: false }, presence: { message: "Email can't be empty" }
  validates :password_digest, presence: { message: "Password Can't be empty" }
  has_many :products,dependent: :destroy
  
  has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'recipient_id'
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id'
  has_many :received_notifications, class_name: 'Notification', foreign_key: 'recipient_id'
  has_secure_password

  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email)
    unless user
      # binding.pry
      user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          password: SecureRandom.alphanumeric(10) # Generate a random password of length 10
      )
    end
    user.retrieve_google_contacts(auth)
    user
  end
  def retrieve_google_contacts(auth)
    contacts = auth[:extra][:raw_info][:contacts]
      # Do something with the contacts data, such as storing it in your database
  end
  def downcase_email
    email.downcase
  end
end