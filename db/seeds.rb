# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
require 'faker'

Item.delete_all
Category.delete_all
Tax.delete_all
User.delete_all

def random_decimal(range)
  rand(range) / 100.0
end

Category.create!([
  { name: 'laptop', information: 'laptop' },
  { name: 'desktop', information: 'desktop pre-builds' },
  { name: 'parts', information: 'computer parts and accessories' },
  { name: 'devices', information: 'mice, keyboard, headphones, monitors and other' },
  { name: 'custom_builds', information: 'custom pre-builds' },
])

categories = Category.all

categories.each do |category|
  20.times do
    Item.create!(
      name: Faker::Commerce.product_name,
      category_id: category.id,
      information: "testing items",
      price: Faker::Number.between(from: 1, to: 1000),
      image: 'noItem.jpg',
      discount: 0,
      last_update: Time.now,
      date_create: Time.now
    )
  end
end

laptop_category = Category.find_by(name: 'laptop')
2.times do
  Item.create(
    name: Faker::Device.model_name,
    category: laptop_category,
    information: "testing items",
    price: Faker::Number.between(from: 1, to: 1000),
    image: 'noItem.jpg',
    discount: 10,
    last_update: Time.now,
    date_create: Time.now
  )
end

parts_category = Category.find_by(name: 'parts')
3.times do
  Item.create(
    name: Faker::Device.model_name,
    category: parts_category,
    information: "testing items",
    price: Faker::Number.between(from: 1, to: 1000),
    image: 'noItem.jpg',
    discount: 0,
    last_update: Time.now,
    date_create: 10.days.ago
  )
end

tax_rates = {
  "AB" => { PST: 0.00, GST: 0.05, HST: 0.00 }, # Alberta
  "BC" => { PST: 0.07, GST: 0.05, HST: 0.00 }, # British Columbia
  "MB" => { PST: 0.07, GST: 0.05, HST: 0.00 }, # Manitoba
  "NB" => { PST: 0.00, GST: 0.00, HST: 0.15 }, # New Brunswick
  "NL" => { PST: 0.00, GST: 0.00, HST: 0.15 }, # Newfoundland and Labrador
  "NS" => { PST: 0.00, GST: 0.00, HST: 0.15 }, # Nova Scotia
  "ON" => { PST: 0.00, GST: 0.00, HST: 0.13 }, # Ontario
  "PE" => { PST: 0.00, GST: 0.00, HST: 0.15 }, # Prince Edward Island
  "QC" => { PST: 0.09975, GST: 0.05, HST: 0.00 }, # Quebec
  "SK" => { PST: 0.06, GST: 0.05, HST: 0.00 }, # Saskatchewan
  "NT" => { PST: 0.00, GST: 0.05, HST: 0.00 }, # Northwest Territories
  "NU" => { PST: 0.00, GST: 0.05, HST: 0.00 }, # Nunavut
  "YT" => { PST: 0.00, GST: 0.05, HST: 0.00 }  # Yukon
}

# Create tax information for each province and territory
tax_rates.each do |tax_region, rates|
  Tax.create!(
    tax_region: tax_region,
    PST: rates[:PST],
    GST: rates[:GST],
    HST: rates[:HST]
  )
end