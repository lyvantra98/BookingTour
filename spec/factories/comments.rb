FactoryBot.define do
  factory :comment do
    content {"hellowocccccrld"}
    parent_id {nil}
    association :user
    association :review
  end
end
