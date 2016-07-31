# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, date_of_birth: '01.01.2001',
             place_of_birth: 'Таганрог, Ростовская область, Россия', location: 'Таганрог, Ростовская область, Россия' ,
             first_name: 'Admin', last_name: 'Admin', middle_name: 'Admin',
             place_id: 'ChIJjXS7CY1X4UARJbMSaKgRHhE', location_id: 'ChIJjXS7CY1X4UARJbMSaKgRHhE')