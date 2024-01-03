# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_OAUTH2_CLIENT_ID'], ENV['GOOGLE_OAUTH2_SECRET_ID']
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_SECRET_ID']
  provider :facebook, ENV['FACEBOOK_CLIENT_ID'], ENV['FACEBOOK_SECRET_ID']
end

OmniAuth.config.allowed_request_methods = %i[get]
