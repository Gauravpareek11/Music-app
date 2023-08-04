# frozen_string_literal:true

# This is omniauth initializer
client_id = Rails.application.credentials.google[:client_id]
client_secret = Rails.application.credentials.google[:client_secret]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, client_id, client_secret, {
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50
  }
end
