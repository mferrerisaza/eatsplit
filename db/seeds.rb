# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Restaurants

restaurant_1 = Restaurant.new(
  name: "Mario",
  type: "Italian",
  address: "Carrer Mallorca 212"
)

restaurant_1.remote_logo_url = "https://i.pinimg.com/originals/88/2d/88/882d883fcf289d704c064da27ed4fa60.png"
restaurant_1.remote_photo_url = "https://www.cnet.com/i/bto/20091214/mario-pizza_610x457.jpg"

restaurant_1.save!


