# frozen_string_literal: true

FactoryBot.define do
  factory :micropost, class: 'Micropost' do
    content { Faker::Lorem.sentence }
    association :user, factory: :user
    parent_id { nil }

    trait :with_parent do
      after(:create) do |micropost, _evaluator|
        parent_micropost = FactoryBot.create(:micropost)
        micropost.update(parent_id: parent_micropost.id)
      end
    end
  end
end
