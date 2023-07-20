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


Category.create!([
  { name: 'laptop', information: 'laptop' },
  { name: 'desktop', information: 'desktop pre-builds' },
  { name: 'parts', information: 'computer parts and accessories' },
  { name: 'devices', information: 'mice, keyboard, headphones, monitors and other' },
  { name: 'custom_builds', information: 'custom pre-builds' },
])

categories = Category.all

categories.each do |category|
  10.times do
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

parts_category = Category.find_by(name: 'parts')
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