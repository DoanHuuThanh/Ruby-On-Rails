# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    uid { Faker::Number.number(digits: 6) }
    provider { Faker::Internet.domain_word }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    confirmation_token { Faker::Internet.uuid }
    activated { true }
  end
end
