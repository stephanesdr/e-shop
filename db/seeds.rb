# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'csv'

# == seed some users ==
puts 'Seeding users...'
1.upto(10) do |i|
  email = Faker::Internet.email
  next p "User already exist" if User.find_by(email: email)

  User.create!(
    email: email,
    password: Faker::Internet.password(8),
    confirmed_at: Time.zone.now
  )
  p "User #{i} : created"
end

# == seed an admin ==
puts 'Seeding admin...'
if !User.find_by(email: "admin@e-shop.com")
  User.create!(
    email: "admin@e-shop.com",
    password: "superpassword",
    confirmed_at: Time.zone.now
  )
  p "Admin created"
else
  p "Admin already exist"
end

# == scrapping phytodata ==
# Use of service scrap_phytodb.rb in app/services/
# Initialize scrapping : true = scrapping, false = initialize without scrapping
# For only seed from csv file, just uncomment ScrapPhytodb.new and scrap.seed_from_csv

# be carful which lign are comment or uncomment
scrap = ScrapPhytodb.new(false)
scrap.delete_items_categories
# scrap.perform
# scrap.seed_items_categories
# scrap.seed_image_url
# scrap.export_to_csv
scrap.seed_from_csv("phyto_db_2019-05-01_23:54:22.csv")
# == -------------------- ==

# == seed some carts ==
puts 'Seeding CartItems...'
1.upto(20) do |i|
  CartItem.create!(
    item_id: Item.all.sample.id,
    cart_id: Cart.all.sample.id
  )
  p "CartItem #{i} : created"
end
