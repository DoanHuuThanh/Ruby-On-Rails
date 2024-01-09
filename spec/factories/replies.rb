# frozen_string_literal: true

FactoryBot.define do
  factory :reply do
    content { 'MyText' }
    user { nil }
    comment { nil }
  end
end
