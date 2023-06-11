Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '300762541567-d697jis6225asi6iabko2o9qnksvv13m.apps.googleusercontent.com', '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', {
    scope: 'email profile https://www.googleapis.com/auth/contacts.readonly',
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50
  }
end