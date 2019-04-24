# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# 1.upto(10) do |i|
#   User.create!(
#     email: Faker::Internet.email,
#     password: Faker::Internet.password(8),
#     confirmed_at: Time.zone.now
#   )
#   p "User #{i} : créé"
# end
#
# 1.upto(30) do |i|
#   Item.create!(
#     price: Faker::Number.decimal(2),
#     name: Faker::Commerce.unique.product_name,
#     description: Faker::GreekPhilosophers.quote,
#     discount: false,
#     percentage_discount: 0
#   )
#   p "Item #{i} : créé"
# end
#
# 1.upto(10) do |i|
#   Category.create!(
#     name: Faker::Commerce.department(1, true)
#   )
#   p "Category #{i} : créé"
# end
#
# 1.upto(10) do |i|
#   CategoryItem.create!(
#     item_id: Item.all.sample.id,
#     category_id: Category.all.sample.id
#   )
#   p "ItemCategory #{i} : créé"
# end
#
# 1.upto(20) do |i|
#   CartItem.create!(
#     item_id: Item.all.sample.id,
#     cart_id: Cart.all.sample.id
#   )
#   p "CartItem #{i} : créé"
# end
