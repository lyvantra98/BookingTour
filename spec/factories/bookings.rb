FactoryBot.define do
  factory :booking do
    status {"waiting"}
    number_people {10}
    association :user
    association :tour
  end
end
