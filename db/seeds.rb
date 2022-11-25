# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# require "faker"
puts "destorying db"
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
  theory = element.search("a").text
  theory_url = "https://en.wikipedia.org/" + element.children[1].attribute("href").value
  theory_file = URI.open(theory_url).read
  theory_doc = Nokogiri::HTML(theory_file)
  theory_description = theory_doc.search("p").first.text.strip
  theory_hash[theory] = [theory_url, theory_description]
end

theory_hash.reject!{ |t| t == ("dynamic listadding missing itemsreliable sources")}

# p theory_hash

20.times do
  theory = theory_hash.keys.sample
  # p theory
  # p theory_hash[theory]
  Theorist.create(
    stage_name: Faker::Name.name,
    main_theory: theory,
    sources: theory_hash[theory][0],
    theory_description: theory_hash[theory][1],
    price: rand(0..1000),
    location: Faker::Address.city,
    user_id: User.all.sample.id,
    photonum: rand(1..70)
  )
end

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
