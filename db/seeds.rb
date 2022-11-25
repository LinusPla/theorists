# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# require "faker"
puts "destorxying db"
Review.destroy_all
Booking.destroy_all
Theorist.destroy_all
User.destroy_all

puts "creating users"
20.times do
  User.create(email: Faker::Internet.email, password: Faker::Alphanumeric.alpha(number: 10))
end

puts "creating theorists"

# scraping Wiki Theory page
require "open-uri"
require "nokogiri"

url = "https://en.wikipedia.org/wiki/List_of_conspiracy_theories"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)
theory_array = []
html_doc.search("h3 .mw-headline").each do |element|
  theory_array << element.children.text
end

theory_hash = {}

html_doc.search(".hatnote").each do |element|
  # p "https://en.wikipedia.org/" + element.children[1].attribute("href").value
  # p element.search("a").text
  theory_hash[element.search("a").text] = "https://en.wikipedia.org/" + element.children[1].attribute("href").value
end

# p theory_hash

20.times do
  theory = theory_hash.keys.sample
  # p theory
  # p theory_hash[theory]
  Theorist.create(
    stage_name: Faker::Name.name,
    main_theory: theory,
    sources: theory_hash[theory],
    price: rand(0..1000),
    location: Faker::Address.city,
    user_id: User.all.sample.id,
    photonum: rand(1..70)
  )
end

Theorist.create(
  stage_name: "Leroy 'lizard eyes' Jenkins",
  main_theory: "The Reptilian Elite",
  sources: "https://content.time.com/time/specials/packages/article/0,28804,1860871_1860876_1861029,00.html",
  price: 500,
  location: "Goerlitzer Park",
  user_id: User.all.sample.id,
  photonum: rand(1..70)
)


Theorist.create(
  stage_name: "Jimmy 'let it rip' Jameson",
  main_theory: "Corona is a load of rubbish",
  sources: "https://en.wikipedia.org/wiki/COVID-19_misinformation",
  price: 400,
  location: "Teufelsberg",
  user_id: User.all.sample.id,
  photonum: rand(1..70)
)

Theorist.create(
  stage_name: "Timmy 'Moon Boots' Manchild",
  main_theory: "The moon landings, my foot mate",
  sources: "https://www.theguardian.com/science/2019/jul/10/one-giant-lie-why-so-many-people-still-think-the-moon-landings-were-faked",
  price: 400,
  location: "Armstrongstr. 0",
  user_id: User.all.sample.id,
  photonum: rand(1..70)
)

Theorist.create(
  stage_name: "Georgy Waters",
  main_theory: "Fluride is making us docile dude",
  sources: "https://en.wikipedia.org/wiki/Water_fluoridation_controversy",
  price: 300,
  location: "Berghain",
  user_id: User.all.sample.id
)

Theorist.create(
  stage_name: "Liam Malone",
  main_theory: "The Us election was rigged",
  sources: "https://en.wikipedia.org/wiki/Italygate",
  price: 250,
  location: "American Embassy, Berlin",
  user_id: User.all.sample.id
)


puts "creating bookings"
30.times do
  Booking.create(
    user_id: User.all.sample.id,
    theorist_id: Theorist.all.sample.id,
    start_date: Faker::Date.between(from: 200.days.ago, to: 100.days.ago),
    end_date: Faker::Date.between(from: 100.days.ago, to: Date.today)
  )
end

puts "creating reviews"

100.times do
  Review.create(
    comment: Faker::Restaurant.review,
    rating: rand(0..5),
    booking_date: Faker::Date.backward(days: 300),
    user_id: User.all.sample.id,
    theorist_id: Theorist.all.sample.id,
  )
end
