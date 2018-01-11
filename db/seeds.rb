# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.delete_all
User.delete_all
Message.delete_all
BidHistory.delete_all
BidAuto.delete_all
Favorite.delete_all

user = User.create!(name:"khoa",email:"123@gmail.com",password:"123", typee:"member", status:"available")
user = User.create!(name:"staff",email:"staff@gmail.com",password:"staff", typee:"staff", status:"available")
user = User.create!(name:"admin",email:"admin@gmail.com",password:"admin", typee:"admin", status:"available")


Category.delete_all
category = Category.create!(name:"Phone")
category2 = Category.create!(name:"Computer")
category3 = Category.create!(name:"Food")
category4 = Category.create!(name:"Beverage")
category5 = Category.create!(name:"Vehicle")
category6 = Category.create!(name:"Book")
category7 = Category.create!(name:"Clothes")
category8 = Category.create!(name:"Furniture")
