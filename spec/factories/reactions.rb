# frozen_string_literal: true

FactoryBot.define do
  factory :reaction do
    action { Faker::Number.between(from: 0, to: 5) }
    association :user, factory: :user
    association :micropost, factory: :micropost
  end
end
