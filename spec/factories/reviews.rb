FactoryBot.define do
  factory :review do
    title {"title tour 1"}
    content {"content 123"}
    association :user
    association :tour
  end
end
