# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users

puts "Seeding the Users"

u = User.new( email: "miguelf7@gmail.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Miguel Ferrer")
u.save!

u = User.new( email: "dan@gmail.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Dan")
u.save!

u = User.new( email: "ollie@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Ollie")
u.save!

puts "Seeding users done"

#Restaurants

puts "Seeding the Restaurants"

restaurant_1 = Restaurant.new(
  name: "Mario's",
  category: "Italian",
  address: "Carrer Mallorca 212"
)

restaurant_1.remote_logo_url = "https://i.pinimg.com/originals/88/2d/88/882d883fcf289d704c064da27ed4fa60.png"
restaurant_1.remote_photo_url = "https://www.cnet.com/i/bto/20091214/mario-pizza_610x457.jpg"
restaurant_1.user = User.find(1)

restaurant_1.save!

puts "Seeding Restaurants done"


#Dishes for Mario's

puts "Seeding the Dishes for Restaurant_id = 1"

dish_1 = Dish.new(
  category: "Starter",
  name: "Pizza Margherita",
  description: "Tomato, Mozzarella fior di latte, Fresh basil",
  price: 12
)
dish_1.restaurant = restaurant_1
dish_1.remote_photo_url = "https://static01.nyt.com/images/2014/04/09/dining/09JPPIZZA2/09JPPIZZA2-superJumbo.jpg"
dish_1.save!

dish_2 = Dish.new(
  category: "Starter",
  name: "Pizza Quattro Stagioni",
  description: "San Marzanoo Tomato, Artichokes, Ham, Olives, Anchovies, Mushrooms",
  price: 14
)
dish_2.restaurant = restaurant_1
dish_2.remote_photo_url = "http://www.basilico.co.uk/sites/default/files/styles/flexslider_full/public/quattro-stagioni-basilico.jpg?itok=uaeRTwGw"
dish_2.save!

dish_3 = Dish.new(
  category: "Main",
  name: "Pasta Carbonara",
  description: "Egg, Cheese, Guanciale, Pepper",
  price: 15.3
)
dish_3.restaurant = restaurant_1
dish_3.remote_photo_url = "https://www.simplyrecipes.com/wp-content/uploads/2012/02/pasta-carbonara-horiz-a-1200.jpg"
dish_3.save!

dish_4 = Dish.new(
  category: "Main",
  name: "Spaghetti alle Vongole",
  description: "Spahetti and clams",
  price: 16
)
dish_4.restaurant = restaurant_1
dish_4.remote_photo_url = "https://www.cucchiaio.it/content/cucchiaio/it/ricette/2017/01/spaghetti-vongole/jcr:content/header-par/image-single.img10.jpg/1484562695919.jpg"
dish_4.save!

dish_5 = Dish.new(
  category: "Desert",
  name: "Tiramisu",
  description: "Coffee chocolate Italian dessert",
  price: 7
)
dish_5.restaurant = restaurant_1
dish_5.remote_photo_url = "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2011/2/4/2/RX-FNM_030111-Sugar-Fix-005_s4x3.jpg.rend.hgtvcom.616.462.suffix/1371597326801.jpeg"
dish_5.save!

puts "finished seeding dishes for Restaurant_id = 1"

puts "Finished Seeding!"







