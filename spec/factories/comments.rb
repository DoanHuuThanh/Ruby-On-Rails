# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyText' }
    user { nil }
    micropost { nil }
    parent_id { 1 }
  end
end
