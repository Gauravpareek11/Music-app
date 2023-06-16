require 'securerandom'
class User < ApplicationRecord
    has_many :products,dependent: :destroy
    has_secure_password
    def self.from_omniauth(auth)
        user = find_by(email: auth.info.email)
        unless user
        user = User.create(
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
end
