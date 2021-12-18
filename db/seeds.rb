# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a main sample user.
User.create!(name:  "Admin", email: "admin123@admin.ru", password: "admin123", password_confirmation: "admin123", admin: true, editor: true)

News.create!(title:  "Тестовый титл", content: "Тестовый контенит", user_id: 1)
News.create!(title:  "Тестовый титл2", content: "Тестовый контенит2", user_id: 1)