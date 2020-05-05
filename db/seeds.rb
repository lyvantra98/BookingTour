User.create!(name: "admin",
  email: "admin@gmail.com",
  password: "12345678",
  password_confirmation: "12345678",
  phone: "+84965116895",
  address: "Hà Nội",
  is_admin: true)
2.times do |n|
  name = FFaker::Name.name
  email = "user#{n + 1}@gmail.com"
  password = "12345678"
  phone = FFaker::PhoneNumberAU.mobile_phone_number
  address = FFaker::AddressAU.full_address
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    phone: phone,
    address: address)
end
3.times do
  Category.create!(name: FFaker::AddressUS.city)
end
categories_parent = Category.all
categories_parent.each do |category|
  2.times do
    city = FFaker::AddressUS.city
    cate1 = Category.create!(
      name: city,
      parent_id: category.id)
    Category.create!(
      name: FFaker::AddressUS.city,
      parent_id: cate1.id)
  end
end
categories = Category.all
categories.each do |category|
  2.times do
    name = FFaker::Conference.name
    date_range = DateTime.now.beginning_of_day +
      rand(60).days +
      rand(24).hours +
      (rand(2) * 30).minutes
    date_from = date_range
    date_to = date_from + 5.days
    location_from = FFaker::AddressUS.city
    location_to = FFaker::AddressUS.city
    price = rand(11.2...760.9)
    max_people = rand(11..50)
    min_people = rand(1..10)
    description = FFaker::Book.description
    Tour.create!(
      name: name,
      date_from: date_from,
      date_to: date_to,
      location_from: location_from,
      location_to: location_to,
      price: price,
      max_people: max_people,
      min_people: min_people,
      description: description,
      category_id: category.id,
      status: 1)
  end
end
tours = Tour.all
user = User.first
tours.each do |tour|
  min_people = tour.min_people
  max_people = tour.max_people
  number_people = rand(min_people..max_people)
  tour.bookings.create!(
    status: rand(0..2),
    number_people: number_people,
    user_id: user.id)
  3.times do
    tour.reviews.create!(
      title: FFaker::Conference.name,
      content: FFaker::Book.description,
      user_id: user.id)
  end
end
reviews = Review.all
user = User.first
reviews.each do |review|
  Comment.create!(
    content: FFaker::Book.description,
    user_id: user.id,
    review_id: review.id)
end
reviews = Review.all
likes = reviews[1..5]
user = User.first
likes.each do |review|
  Like.create!(
    review_id: review.id,
    user_id: user.id)
end
comments = Comment.take(4)
user = User.second
comments.each do |comment|
  2.times do
    Comment.create!(
      content: FFaker::Book.description,
      parent_id: comment.id,
      review_id: comment.review_id,
      user_id: user.id)
  end
end
