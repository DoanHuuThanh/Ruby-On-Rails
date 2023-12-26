FactoryBot.define do
  factory :reply do
    content { "MyText" }
    user { nil }
    comment { nil }
  end
end
