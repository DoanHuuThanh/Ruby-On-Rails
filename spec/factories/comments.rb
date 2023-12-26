FactoryBot.define do
  factory :comment do
    content { "MyText" }
    micropost { nil }
    user { nil }
  end
end
