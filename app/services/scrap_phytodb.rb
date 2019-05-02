# frozen_string_literal: true

# == Service for scrapping database of medicinal plants from the site : ==
# == https://www.creapharma.ch ==
#
# This service is called from seed.rb
#
# == Instance variables declaration ==
#
# == Methoods ==
#
# Initialize(scrap)
# scrap_categories_items
# scrap_description_images
# create_hash_plants_diseases /!\ execute after scrap methods
# seed_items_categories /!\ execute after scrap and create hash methods
# seed_image_url /!\ execute after scrap and create hash methods
# export_to_csv /!\ execute after scrap and create hash methods
# seed_from_csv(file) : only dependant with file.csv
# delete_items_categories
# perform

require 'faker'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'pry'

class ScrapPhytodb
  attr_accessor :hash_plants_url, :hash_disease_plants,
                :hash_plants_description, :hash_plants_photo_url,
                :hash_plants_disease

  def initialize(scrap = true)
    return unless scrap

    puts '## Initialization of scrapping..............'
    @hash_plants_url = {}
    @hash_diseases_plants = {}
    @hash_plants_diseases = {}
    @hash_plant_description = {}
    @hash_plant_photo_url = {}
    # url scrapped
    puts '## Scrapping "https://www.creapharma.ch"..............'
    url = "https://www.creapharma.ch/plante_medicinale.htm"
    @url_home = Nokogiri::HTML(URI.parse(url).open)
    @n = @url_home.css('.heilp-list ul li').count
  end

  def scrap_categories_items
    puts '## Scrapping items and categories.....................'
    t_begin = Time.now.in_time_zone

    @n.times do |i|
      lign = @url_home.css('.heilp-list ul li')[i + 1]
      if lign
        disease = lign.text.split(':').first.capitalize
        if !disease.nil? && disease.length > 1
          puts "#{i} : scrapping #{disease}..."
          lign.css('a').each do |plant|
            if @hash_diseases_plants[disease].nil?
              @hash_diseases_plants[disease] = [plant.text.capitalize]
            else
              @hash_diseases_plants[disease] << plant.text.capitalize
            end
            @hash_plants_url[plant.text.capitalize] = plant.css('@href').text
          end
        end
      end
      if i == 176 then break end
    end
    t_end = Time.now.in_time_zone
    puts "Scrap done in #{t_end - t_begin} secondes."
  end

  def scrap_description_images
    i = 1
    puts '## Scrapping desciptions and images.....................'
    t_begin = Time.now.in_time_zone

    @hash_plants_url.each do |plant, url|
      result = Net::HTTP.get(URI.parse(url))
      puts "#{i} : scrapping #{plant}..."
      if result.include? '404 Not Found'
        p '.....url not found - 404 Not Found'
        @hash_plant_description[plant] = 'url not found'
        @hash_plant_photo_url[plant] = 'url not found'
      else
        url_plant = Nokogiri::HTML(URI.parse(url).open)
        @hash_plant_description[plant] = url_plant.css('.entry-content p').first.text
        puts "Description : #{url_plant.css('.entry-content p').first.text}"
        @hash_plant_photo_url[plant] = url_plant.css('.dekokt-prod-img @src').text
        puts "Photo_url : #{url_plant.css('.dekokt-prod-img @src').text}"
      end
      i += 1
    end
    t_end = Time.now.in_time_zone
    puts "Scrap done in #{t_end - t_begin} secondes."
  end

  def create_hash_plants_diseases
    # This hash is "reverse" of hash_diseases_plants
    puts '## Create hash_plants_diseases.....................'
    @hash_diseases_plants.each do |disease, plants|
      plants.each do |plant|
        if @hash_plants_diseases[plant].nil?
          @hash_plants_diseases[plant] = [disease]
        else
          @hash_plants_diseases[plant] << disease
        end
      end
    end
  end

  def seed_items_categories
    # This method is no more usefull regarding seed_from_csv method
    puts '## Seeding items and categories.....................'
    @hash_plants_diseases.each do |plant, diseases|
      item = Item.create(name: plant,
                         description: @hash_plant_description[plant],
                         price: Faker::Number.decimal(2),
                         discount: false,
                         percentage_discount: 0)
      diseases.each do |disease|
        item.categories << (Category.find_by(name: disease) || Category.create(name: disease))
      end
    end
  end

  def seed_image_url
    # This method is no more usefull regarding seed_from_csv method
    puts '## Seeding url of items images.....................'
    @hash_plant_photo_url.each do |plant, photo_url|
      Item.find_by(name: plant)&.update(image_url: photo_url)
    end
  end

  def export_to_csv
    # This method is to use only after scrap_categories_items,
    # scrap_description_images and create_hash_plants_diseases methods
    puts '## Export data to CSV.....................'
    file = "db/phyto_db_#{Time.now.utc.to_s[0..-5].gsub!(/\s/, '_')}.csv"
    CSV.open(file, "wb") do |csv|
      csv << ["name", "description", "photo_url", "diseases"]
      @hash_plant_description.each do |plant, description|
        csv << [plant, description, @hash_plant_photo_url[plant], @hash_plants_diseases[plant].join(', ')]
      end
    end
  end

  def seed_from_csv(file)
    puts '## Seed data from CSV.....................'
    CSV.foreach(file, headers: true) do |row|
      # 0: Name - # 1: Description - # 2: image_url - # 3: diseases
      item = Item.create(name: row[0],
                         description: row[1],
                         image_url: row[2],
                         price: Faker::Number.decimal(2),
                         discount: false,
                         percentage_discount: 0)
      row[3].gsub(160.chr("UTF-8"), " ").split(' , ').each do |disease|
        item.categories << (Category.find_by(name: disease) || Category.create(name: disease))
      end
    end
  end

  def delete_items_categories
    puts '## Delete all items and categories.....................'
    Item.all.each do |item|
      CartItem.where(item_id: item.id).each { |cart_item| CartItem.delete(cart_item) }
      CategoryItem.where(item_id: item.id).each { |category_item| CategoryItem.delete(category_item) }
      ItemOrder.where(item_id: item.id).each { |order_item| ItemOrder.delete(order_item) }
      Item.delete(item)
    end
    Category.delete_all
  end

  def perform
    scrap_categories_items
    scrap_description_images
    create_hash_plants_diseases
  end
end
