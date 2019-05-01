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

hash_medoc = {}

CSV.foreach(Rails.root.join("db", "cis_bdpm.csv"), headers: true, col_sep: ';' ) do |row|
  hash_medoc[row["code_identifiant"]] = Hash.new((row['code_identifiant']).to_s)
  hash_medoc[row["code_identifiant"]]["code_identifiant"] = row["code_identifiant"]
  hash_medoc[row["code_identifiant"]]["nom"] = row["denomination"]
  hash_medoc[row["code_identifiant"]]['forme_pharmaceutique'] = row["forme_pharmaceutique"]
  hash_medoc[row["code_identifiant"]]['laboratoire'] = row["laboratoire"]
end
puts "CSV 1 DONE"

CSV.foreach(Rails.root.join("db", "cis_cip_bdpm.csv"), headers: true, col_sep: ';' ) do |row|
  if hash_medoc.key?(row["code_identifiant"])
    hash_medoc[row["code_identifiant"]]['libéllé'] = row["libéllé"]
    hash_medoc[row["code_identifiant"]]['prix'] = row["prix€"]
    hash_medoc[row["code_identifiant"]]['indications_remboursement'] = row["indications_remboursement"]
    hash_medoc[row["code_identifiant"]]['taux_remboursement'] = row["taux_remboursement"]
  end
end
puts "CSV 2 DONE"

CSV.foreach(Rails.root.join("db", "cis_compo_bdpm.csv"), headers: true, col_sep: ';' ) do |row|
  if hash_medoc.key?(row["code_identifiant"])
    hash_medoc[row["code_identifiant"]]['format_administration'] = row["format_administration"]
    hash_medoc[row["code_identifiant"]]['denomination_de_la_substance'] = row["denomination_de_la_substance"]
    hash_medoc[row["code_identifiant"]]['dosage_de_la_substance'] = "#{row['dosage_de_la_substance']}/#{row['réferent_dosage']}"
  end
end
puts "CSV 3 DONE"

CSV.foreach(Rails.root.join("db", "cis_infoimportantes_bdpm.csv"), headers: true, col_sep: ';' ) do |row|
  if hash_medoc.key?(row["code_identifiant"])
    hash_medoc[row["code_identifiant"]]['information_de_sécurite'] = row["information_de_sécurite"]
  end
end
puts "CSV 4 DONE"

puts hash_medoc.sort

arr_labo = []
CSV.foreach(Rails.root.join("db", "cis_bdpm.csv"), headers: true, col_sep: ';' ) do |row|
  if !arr_labo.include?(row["laboratoire"])
    arr_labo << row["laboratoire"]
  end
end
# puts arr_labo

arr_categories = []
CSV.foreach(Rails.root.join("db", "cis_compo_bdpm.csv"), headers: true, col_sep: ';' ) do |row|
  if !arr_categories.include?(row["format_administration"].split(" ")[0].to_s)
    arr_categories << row["format_administration"].split(" ")[0].to_s
  end
end
# puts arr_categories

# arr_labo.each {|labo| Laboratoire.create(name: labo)}
# puts "Laboratoire seeds generated !"

# arr_categories.each {|category| Category.create(name: category)}
# puts "Categorie seeds generated !"

#-------OLD SEEDS--------------------------
# 1.upto(10) do |i|
#   User.create!(
#     email: Faker::Internet.email,
#     password: Faker::Internet.password(8),
#     confirmed_at: Time.zone.now
#   )
#   p "User #{i} : créé"
# end
#
# 1.upto(10) do |i|
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
