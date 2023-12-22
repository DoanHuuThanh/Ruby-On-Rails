FactoryBot.define do
  factory :user do
    name { 'Thành Đoàn' }
    email { 'thanh022302@gmail.com' }
    created_at { '2023-12-21 06:51:09.396513' }
    updated_at { '2023-12-21 07:04:09.960061' }
    password { '123' }
    password_confirmation { '123' }
    remember_digest { nil }
    admin { nil }
    activation_digest { '$2a$12$zkDfrZ2HkxBmUrGI//xX6.RolBJQGW5ZJp2n0A.Y8x8ep.wiUFNgi' }
    activated { false }
    activated_at { nil }
    reset_digest { nil }
    reset_sent_at { nil }
    oauth_token { '[FILTERED]' }
    oauth_expires_at { nil }
    provider { 'google_oauth2' }
    uid { '101336651117066274559' }
  end
end
