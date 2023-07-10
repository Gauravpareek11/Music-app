client_id=Rails.application.credentials.google[:client_id]
client_secret=Rails.application.credentials.google[:client_secret]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, client_id, client_secret, {
    scope: 'email profile https://www.googleapis.com/auth/contacts.readonly',
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50
  }
end