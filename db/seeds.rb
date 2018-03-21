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
u.profile.remote_photo_url = "https://kitt.lewagon.com/placeholder/users/random"
u.save!

u = User.new( email: "dan@gmail.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Dan")
u.profile.remote_photo_url = "https://d1qb2nb5cznatu.cloudfront.net/users/5676816-large?1488403186"
u.save!

u = User.new( email: "ollie@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Ollie")
u.profile.remote_photo_url = "http://kwartierenruimschoteloverakker.voorouders.net/thumb/37/o_ft_29038"
u.save!

u = User.new( email: "eduardo@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Eduardo")
u.profile.remote_photo_url = "https://media.licdn.com/dms/image/C4E03AQFTs_3JKjFcFQ/profile-displayphoto-shrink_800_800/0?e=1526752800&v=alpha&t=jaZKq772q79DScllEkaRqtNeR3w47gQ1m9nSjB0Vr-E"
u.save!

u = User.new( email: "victor@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Victor")
u.profile.remote_photo_url = "https://frontrow.ventures/images/team/team/victor-64b8b8b9.jpg"
u.save!

u = User.new( email: "luke@skywalker.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Luke")
u.profile.remote_photo_url = "https://i.ytimg.com/vi/GIVaFxZkAPs/maxresdefault.jpg"
u.save!

u = User.new( email: "leia@princess.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Leia")
u.profile.remote_photo_url = "https://i.ebayimg.com/images/g/oVMAAOSw9GhYbkwu/s-l300.jpg"
u.save!

u = User.new( email: "darth@vader.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Darth Vader")
u.profile.remote_photo_url = "http://clipart-library.com/images/6cr5d9qLi.jpg"
u.save!

u = User.new( email: "jarjar@binks.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Jar Jar")
u.profile.remote_photo_url = "http://sethspopcorn.com/wp-content/uploads/2010/10/jar-jar-binks1.jpg"
u.save!

u = User.new( email: "juan@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Tanja")
u.save!

u = User.new( email: "avalon@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Victor")
u.save!

u = User.new( email: "eric@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Johann")
u.save!

u = User.new( email: "joe@test.com", password:"123456", password_confirmation:"123456")
u.profile = Profile.create(name: "Tanja")
u.save!
puts "Seeding users done"

#Restaurants

puts "Seeding the Restaurants"

restaurant_1 = Restaurant.new(
  name: "Mario's",
  category: "Italian",
  address: "Carrer Grassot 101"
)

restaurant_1.remote_logo_url = "https://www.le-ratelier.com/upload/pages-dynamiques/pdmqjxrc-couverts_couleur.png"
restaurant_1.remote_photo_url = "https://media-cdn.tripadvisor.com/media/photo-s/0b/50/62/2c/the-restaurant-at-the.jpg"
restaurant_1.user = User.find(1)

restaurant_1.save!

restaurant_2 = Restaurant.new(
  name: "Pizza barça",
  category: "Italian",
  address: "Carrer Grassot 101"
)

restaurant_2.remote_logo_url = "https://hillsboroughcheese.files.wordpress.com/2016/03/laplace_logowhite.png"
restaurant_2.remote_photo_url = "https://kintamaniid-a903.kxcdn.com/wp-content/uploads/Hotel-The-One-Legian-4-1024x683.jpg"
restaurant_2.user = User.find(1)

restaurant_2.save!

restaurant_3 = Restaurant.new(
  name: "Burger castellano",
  category: "Spanish",
  address: "Moscow, Russia"
)

restaurant_3.remote_logo_url = "http://www.restaurant-la-croix-blanche.ch/images/sampledata/contact/logo-chef.png"
restaurant_3.remote_photo_url = "http://www.lestresoms.com/_cache/resize/1920-744.crop/d2eb0d9965833944c5f8e3e9fe7c535a.jpg"
restaurant_3.user = User.find(1)

restaurant_3.save!

restaurant_4 = Restaurant.new(
  name: "Syri",
  category: "Syrian",
  address: "Carrer de València 334"
)

restaurant_4.remote_logo_url = "http://logo-load.com/uploads/posts/2016-04/1459873183_texas-roadhouse-logo.png"
restaurant_4.remote_photo_url = "https://ugc.zenchef.com/3/4/8/6/5/8/1/5/0/0/4/8/8/1500558718_293/b824a46e829f055b4ad94da613c66316.website.jpg"
restaurant_4.user = User.find(1)

restaurant_4.save!


restaurant_5 = Restaurant.new(
  name: "Spoonik",
  category: "Experimental",
  address: "Carrer de Bertran, 28, 08023 Barcelona"
)
restaurant_5.remote_logo_url = "http://logo-load.com/uploads/posts/2016-04/1459873183_texas-roadhouse-logo.png"
restaurant_5.remote_photo_url = "https://ugc.zenchef.com/3/4/8/6/5/8/1/5/0/0/4/8/8/1500558718_293/b824a46e829f055b4ad94da613c66316.website.jpg"
restaurant_5.user = User.find(1)

restaurant_5.save!

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
  category: "Dessert",
  name: "Tiramisu",
  description: "Coffee chocolate Italian dessert",
  price: 7
)
dish_5.restaurant = restaurant_1
dish_5.remote_photo_url = "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2011/2/4/2/RX-FNM_030111-Sugar-Fix-005_s4x3.jpg.rend.hgtvcom.616.462.suffix/1371597326801.jpeg"
dish_5.save!

puts "finished seeding dishes for Restaurant_id = 1"


#Tables

puts "seeding your tables"

table_1 = Table.new(
  number: 1
)
table_1.restaurant = restaurant_1

table_2 = Table.new(
  number: 2
)
table_2.restaurant = restaurant_1

table_3 = Table.new(
  number: 3
)
table_3.restaurant = restaurant_1

puts "fishised seeding your tables"


#Bills

puts "seeding your bills"

bill_1 = Bill.create(
  table: table_1
)

bill_2 = Bill.create(
  table: table_2
)

bill_3 = Bill.create(
  table: table_3
)

puts "finished seeding your bills"


#Orders

puts "Seeding your orders"

order_1 = Order.new(
  quantity: 2
)
order_1.user = User.find(1)
order_1.dish = dish_1
order_1.bill = bill_1
order_1.amount = order_1.quantity * order_1.dish.price
order_1.save!

order_2 = Order.new(
  quantity: 1
)
order_2.user = User.find(2)
order_2.dish = dish_2
order_2.bill = bill_2
order_2.amount = order_2.quantity * order_2.dish.price
order_2.save!

order_3 = Order.new(
  quantity: 1
)
order_3.user = User.find(3)
order_3.dish = dish_3
order_3.bill = bill_2
order_3.amount = order_3.quantity * order_3.dish.price
order_3.save!

order_4 = Order.new(
  quantity: 1
)
order_4.user = User.find(4)
order_4.dish = dish_3
order_4.bill = bill_2
order_4.amount = order_4.quantity * order_4.dish.price
order_4.save!

order_5 = Order.new(
  quantity: 1
)
order_5.user = User.find(3)
order_5.dish = dish_3
order_5.bill = bill_3
order_5.amount = order_5.quantity * order_5.dish.price
order_5.save!

order_6 = Order.new(
  quantity: 1
)
order_6.user = User.find(4)
order_6.dish = dish_3
order_6.bill = bill_3
order_6.amount = order_6.quantity * order_6.dish.price
order_6.save!


order_7 = Order.new(
  quantity: 1
)
order_7.user = User.find(5)
order_7.dish = dish_3
order_7.bill = bill_3
order_7.amount = order_7.quantity * order_7.dish.price
order_7.save!

order_8 = Order.new(
  quantity: 1
)
order_8.user = User.find(6)
order_8.dish = dish_3
order_8.bill = bill_3
order_8.amount = order_8.quantity * order_8.dish.price
order_8.save!

order_9 = Order.new(
  quantity: 1
)
order_9.user = User.find(7)
order_9.dish = dish_3
order_9.bill = bill_2
order_9.amount = order_9.quantity * order_9.dish.price
order_9.save!

order_8 = Order.new(
  quantity: 1
)
order_8.user = User.find(8)
order_8.dish = dish_3
order_8.bill = bill_3
order_8.amount = order_8.quantity * order_8.dish.price
order_8.save!
puts "finished seeding your orders"


#Adding the balance to the bills and saving the bills

bill_1.orders.each do |order|
  bill_1.balance += order.amount
end


puts "Finished Seeding!"







