# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Comment.destroy_all
ReviewTag.destroy_all
Review.destroy_all
Item.destroy_all
Tag.destroy_all
Category.destroy_all
User.destroy_all

puts "Seeding database..."

# -------------------
# Users
# -------------------
users = [
  {username: "alice", email: "alice@example.com", password: "password"},
  {username: "bob", email: "bob@example.com", password: "password"},
  {username: "carol", email: "carol@example.com", password: "password"},
  {username: "admin", email: "admin@example.com", password: "adminpassword", admin: true}
]

users.each do |u|
  User.create!(u)
end
puts "Created #{User.count} users."

# -------------------
# Categories
# -------------------
categories = ["Movie", "Book", "Game", "Restaurant"]

categories.each do |c|
  Category.create!(name: c)
end
puts "Created #{Category.count} categories."

# -------------------
# Items
# -------------------
items = [
  {title: "Inception", category: Category.find_by(name: "Movie"), year: 2010, creator_name: "Christopher Nolan", image_url: ""},
  {title: "The Hobbit", category: Category.find_by(name: "Book"), year: 1937, creator_name: "J.R.R. Tolkien", image_url: ""},
  {title: "The Witcher 3", category: Category.find_by(name: "Game"), year: 2015, creator_name: "CD Projekt Red", image_url: ""},
  {title: "Sushi Place", category: Category.find_by(name: "Restaurant"), year: nil, creator_name: "Chef Sato", image_url: ""}
]

items.each do |i|
  Item.create!(i)
end
puts "Created #{Item.count} items."

# -------------------
# Tags
# -------------------
tags = ["Action", "Adventure", "RPG", "Horror", "Sci-Fi", "Fantasy", "Italian", "Japanese", "Romance"]

tags.each do |t|
  Tag.create!(name: t)
end
puts "Created #{Tag.count} tags."

# -------------------
# Reviews
# -------------------
reviews = [
  {user: User.find_by(username: "alice"), item: Item.find_by(title: "Inception"), rating: 5, title: "Mind-blowing!", body: "Inception is a masterpiece that bends reality and keeps you thinking."},
  {user: User.find_by(username: "bob"), item: Item.find_by(title: "The Hobbit"), rating: 4, title: "Great adventure", body: "A fun read full of adventure and memorable characters."},
  {user: User.find_by(username: "carol"), item: Item.find_by(title: "The Witcher 3"), rating: 5, title: "Best RPG ever", body: "Amazing world, storytelling, and gameplay."},
  {user: User.find_by(username: "alice"), item: Item.find_by(title: "Sushi Place"), rating: 4, title: "Delicious sushi", body: "Fresh ingredients and excellent service."}
]

reviews.each do |r|
  review = Review.create!(r)
  # Randomly assign 1-3 tags to each review
  review.tags << Tag.order("RANDOM()").limit(rand(1..3))
end
puts "Created #{Review.count} reviews."

# -------------------
# Comments
# -------------------
comments = [
  {user: User.find_by(username: "bob"), review: Review.first, body: "Totally agree, Inception blew my mind too!"},
  {user: User.find_by(username: "carol"), review: Review.first, body: "I need to watch it again."},
  {user: User.find_by(username: "alice"), review: Review.second, body: "Yes, The Hobbit is a classic."},
  {user: User.find_by(username: "bob"), review: Review.third, body: "Witcher 3 is incredible!"}
]

comments.each do |c|
  Comment.create!(c)
end
puts "Created #{Comment.count} comments."

puts "Seeding done!"
