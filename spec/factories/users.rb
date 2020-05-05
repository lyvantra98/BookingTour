FactoryBot.define do
  factory :user do
    name {"admin1"}
    sequence(:email) {|i| "email#{i}@gmail.com"}
    phone {"988755641"}
    address {"handico1"}
    password {"12345671"}
    is_admin {false}
  end
end
