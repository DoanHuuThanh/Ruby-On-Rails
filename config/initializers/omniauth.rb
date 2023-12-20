Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1080386213125-8pij9si1h78g3a5qkt5v9tkpvjoc5a40.apps.googleusercontent.com','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'
end
OmniAuth.config.allowed_request_methods = %i[get]
