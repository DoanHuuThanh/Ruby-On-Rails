Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1080386213125-8pij9si1h78g3a5qkt5v9tkpvjoc5a40.apps.googleusercontent.com','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'
  provider :github, 'eb59af1918b223829340', '9aade850c98e5d9d6dcb681a3d8bda63afbc1207'
  provider :facebook, '806492537950646', '9e37e309fec6249c3190c9d0a65ba2ed'
end

OmniAuth.config.allowed_request_methods = %i[get]
