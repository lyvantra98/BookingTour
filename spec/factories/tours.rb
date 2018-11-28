FactoryBot.define do
  factory :tour do
    status {"open"}
    name {"Tour HN - DN 3 ngày 2 đêm"}
    date_from {"12/10/2018"}
    date_to {"15/10/2018"}
    location_from {"Ha Noi"}
    location_to {"Da nang"}
    price {1200}
    max_people {45}
    min_people {40}
    description {"example 1"}
    association :category
  end
end
