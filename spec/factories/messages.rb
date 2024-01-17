# frozen_string_literal: true

FactoryBot.define do
  factory :message, class: 'Message' do
    content { Faker::Lorem.sentence }
    association :user, factory: :user
    status { nil }

    trait :receiver do
      receiver { 2 }
    end

    trait :conversation do
      conversation_id { 1 }
    end
  end
end
