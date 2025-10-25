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
u.save!
u.profile.update(name: "Miguel Ferrer")
u.profile.update(remote_photo_url: "https://avatars.githubusercontent.com/u/33907120?v=4")
u.save!

u = User.new( email: "dan@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Dan")
u.profile.update(remote_photo_url: "https://d1qb2nb5cznatu.cloudfront.net/users/5676816-large?1488403186")
u.save!

u = User.new( email: "ollie@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Ollie")
u.profile.update(remote_photo_url: "https://i.ytimg.com/vi/GIVaFxZkAPs/maxresdefault.jpg")
u.save!

u = User.new( email: "eduardo@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Eduardo")
u.profile.update(remote_photo_url: "https://avatars.githubusercontent.com/u/20347445?v=4")
u.save!

u = User.new( email: "victor@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Victor")
u.save!

u = User.new( email: "luke@skywalker.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Luke")
u.profile.update(remote_photo_url: "https://i.ytimg.com/vi/GIVaFxZkAPs/maxresdefault.jpg")
u.save!

u = User.new( email: "leia@princess.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Leia")
u.profile.update(remote_photo_url: "https://i.ebayimg.com/images/g/oVMAAOSw9GhYbkwu/s-l300.jpg")
u.save!

u = User.new( email: "darth@vader.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Darth Vader")
u.profile.update(remote_photo_url: "http://clipart-library.com/images/6cr5d9qLi.jpg")
u.save!

u = User.new( email: "jarjar@binks.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Jar Jar")
u.profile.update(remote_photo_url: "https://i.ytimg.com/vi/GIVaFxZkAPs/maxresdefault.jpg")
u.save!

u = User.new( email: "juan@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Tanja")

u = User.new( email: "avalon@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Victor")

u = User.new( email: "eric@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Johann")

u = User.new( email: "joe@gmail.com", password:"123456", password_confirmation:"123456")
u.save!
u.profile.update(name: "Tanja")
puts "Seeding users done"

#Restaurants

puts "Seeding the Restaurants"

restaurant_1 = Restaurant.new(
  name: "Le Wagon",
  category: "French",
  address: "Calle de , 101, 28006 Madrid"
)


restaurant_1.user = User.find(1)

restaurant_1.save!

restaurant_2 = Restaurant.new(
  name: "Pizza barça",
  category: "Italian",
  address: "Calle de la Princesa, 38, 28008 Madrid"
)

restaurant_2.remote_logo_url = "https://hillsboroughcheese.files.wordpress.com/2016/03/laplace_logowhite.png"
restaurant_2.remote_photo_url = "https://media-cdn.tripadvisor.com/media/photo-s/0b/50/62/2c/the-restaurant-at-the.jpg"
restaurant_2.user = User.find(1)

restaurant_2.save!

restaurant_3 = Restaurant.new(
  name: "Burger castellano",
  category: "Spanish",
  address: "Paseo del Prado, 34, 28014 Madrid"
)


restaurant_3.user = User.find(1)

restaurant_3.save!

restaurant_4 = Restaurant.new(
  name: "Syri",
  category: "Syrian",
  address: "Calle de Valencia, 334, 28012 Madrid"
)

restaurant_4.remote_photo_url = "https://ugc.zenchef.com/3/4/8/6/5/8/1/5/0/0/4/8/8/1500558718_293/b824a46e829f055b4ad94da613c66316.website.jpg"
restaurant_4.user = User.find(1)

restaurant_4.save!


restaurant_5 = Restaurant.new(
  name: "Spoonik",
  category: "Experimental",
  address: "Calle de Velázquez, 28, 28001 Madrid"
)
restaurant_5.remote_photo_url = "https://images.unsplash.com/photo-1474898856510-884a2c0be546?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=c273248fe3fdc5d05883723a21f176c1&auto=format&fit=crop&w=1867&q=80"
restaurant_5.user = User.find(1)

restaurant_5.save!

restaurant_6 = Restaurant.new(
  name: "Le Grand",
  category: "French",
  address: "Calle de Alcalá, 84, 28009 Madrid"
)
restaurant_6.remote_photo_url = "https://images.unsplash.com/photo-1483648969698-5e7dcaa3444f?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b984f9f71649300b61dc95407345458c&auto=format&fit=crop&w=1867&q=80"
restaurant_6.user = User.find(1)

restaurant_6.save!

restaurant_7 = Restaurant.new(
  name: "El Rey",
  category: "Local",
  address: "Calle de Fuencarral, 476, 28004 Madrid"
)
restaurant_7.remote_photo_url = "https://images.unsplash.com/photo-1416453072034-c8dbfa2856b5?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=697e11b28dc962b068e3ea85d2a6538c&auto=format&fit=crop&w=2258&q=80"
restaurant_7.user = User.find(1)

restaurant_7.save!

restaurant_8 = Restaurant.new(
  name: "Chef Burger",
  category: "Burgers",
  address: "Calle de Ponzano, 18, 28010 Madrid"
)
restaurant_8.user = User.find(1)

restaurant_8.save!

puts "Seeding Restaurants done"


#Dishes for Mario's

puts "Seeding the Dishes for Restaurant_id = 1"

dish_1 = Dish.new(
  category: "Main",
  name: "Pizza Margherita",
  description: "Tomato, Mozzarella fior di latte, Fresh basil",
  price: 12
)
dish_1.restaurant = restaurant_1
dish_1.remote_photo_url = "https://static01.nyt.com/images/2014/04/09/dining/09JPPIZZA2/09JPPIZZA2-superJumbo.jpg"
dish_1.save!

dish_2 = Dish.new(
  category: "Main",
  name: "Pizza Quattro Stagioni",
  description: "San Marzanoo Tomato, Artichokes, Ham, Olives, Anchovies, Mushrooms",
  price: 14
)
dish_2.restaurant = restaurant_1
dish_2.save!

dish_3 = Dish.new(
  category: "Main",
  name: "Pasta Carbonara",
  description: "Egg, Cheese, Guanciale, Pepper",
  price: 15.3
)
dish_3.restaurant = restaurant_1
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
dish_5.save!

dish_6 = Dish.new(
  category: "Drink",
  name: "Mojito",
  description: "Rum, lime, mint and sugar mixed with soda water.",
  price: 9
)
dish_6.restaurant = restaurant_1
dish_6.save!

dish_7 = Dish.new(
  category: "Drink",
  name: "Beer",
  description: "Italian beer you'll love.",
  price: 4
)
dish_7.restaurant = restaurant_1
dish_7.save!

dish_8 = Dish.new(
  category: "Drink",
  name: "Red dragon",
  description: "Spicy Rhum Cocktail.",
  price: 9
)
dish_8.restaurant = restaurant_1
dish_8.save!

dish_9 = Dish.new(
  category: "Starter",
  name: "Tomato Mozzarella",
  description: "Delicious salad composed of fresh tomatoes and mozzarella.",
  price: 5
)
dish_9.restaurant = restaurant_1
dish_9.save!

dish_10 = Dish.new(
  category: "Dessert",
  name: "Rasberry Bowl",
  description: "Fresh rasberries picked from the chef's garden.",
  price: 6
)
dish_10.restaurant = restaurant_1
dish_10.remote_photo_url = "https://images.unsplash.com/44/Y51aFguqRcGTgsYRYBXV_20140104_085932.jpg?ixlib=rb-0.3.5&s=fb32189a0f9ee4105efc6b852ba18fcb&auto=format&fit=crop&w=2378&q=80"
dish_10.save!

dish_11 = Dish.new(
  category: "Starter",
  name: "Empañadas",
  description: "4 beef empañadas to share with friends.",
  price: 8
)
dish_11.restaurant = restaurant_1
dish_11.remote_photo_url = "https://assets.epicurious.com/photos/5761d20e42e4a5ed66d1df48/master/pass/empanada-dough.jpg"
dish_11.save!

puts "finished seeding dishes for Restaurant_id = 1"


#Tables

puts "seeding your tables"

table_1 = Table.new(
  number: 129
)
table_1.restaurant = restaurant_1

table_2 = Table.new(
  number: 1
)
table_2.restaurant = restaurant_1

table_3 = Table.new(
  number: 2
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
