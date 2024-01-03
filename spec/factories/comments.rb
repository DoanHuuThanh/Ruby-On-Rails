# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence }
    association :user, factory: :user
    parent_id { nil }
  end
end

FactoryBot.define do
  factory :micropost_with_parent, class: 'Micropost' do
    content { Faker::Lorem.sentence }
    association :user, factory: :user
    after(:create) do |micropost_with_parent, _evaluator|
      micropost = FactoryBot.create(:micropost)
      micropost_with_parent.update(parent_id: micropost.id)
    end
  end
end
