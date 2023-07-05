# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(name: 'Gaurav Pareek', email: 'gaurav@gmail.com', password: '1234')
user2 = User.create(name: 'Lokesh kumar', email: 'lokesh@gmail.com', password: '1234')
user3 = User.create(name: 'Mahfuz Alam', email: 'Mahfuz@gmail.com', password: '1234')
admin = User.create(name: 'Admin', email: 'admin@gmail.com', password: '1234', admin: true)

user1 = User.first
user2 = User.second
user3 = User.third
admin = User.fourth
Category.create(items: 'String Instruments')
Category.create(items: 'Electronic Instruments')
Category.create(items: 'Percussion Instruments')
Category.create(items: 'Wind Instruments')
Category.create(items: 'Other Instruments')

Category.first.sub_categories.create(items: 'Acoustic Guitar')
Category.first.sub_categories.create(items: 'Violin')
Category.first.sub_categories.create(items: 'Cello')
Category.first.sub_categories.create(items: 'Classical Guitar')
Category.first.sub_categories.create(items: 'Harp')

Category.second.sub_categories.create(items: 'Digital Piano')
Category.second.sub_categories.create(items: 'Electronic Guitar')
Category.second.sub_categories.create(items: 'Keyboard Piano')

Category.third.sub_categories.create(items: 'Tabla')
Category.third.sub_categories.create(items: 'Drum Set')
Category.third.sub_categories.create(items: 'Dholak')

Category.fourth.sub_categories.create(items: 'Flute')
Category.fourth.sub_categories.create(items: 'Saxophone')
Category.fourth.sub_categories.create(items: 'Clarinet')

Category.fifth.sub_categories.create(items: 'Harmonium')
product1 = Product.create(title: 'Yemaha Acoustic Guitar',
                          description: 'Yemaha Acoustic Guitar all strings working 2 months old',
                          user_name: 'Gaurav', phone_number: '8999999964', price: '1500', role: 'Seller', location: 'patna',
                          user_id: user1.id, category_id: Category.first.id, sub_category_id: Category.first.sub_categories.first.id, approved_by: admin.id)
image_paths = ['Acoustic-guitar1.jpg', 'Acoustic-guitar2.jpg',
               'Acoustic-guitar3.jpg', 'Acoustic-guitar4.jpg', 'Acoustic-guitar5.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product1.images.attach(io: File.open(path), filename: image_path)
end

product2 = Product.create(title: 'Vintage Classical Guitar',
                          description: 'Vintage Classical Guitar still working from 70 years',
                          user_name: 'Gaurav', phone_number: '8999999964', price: '5000', role: 'Seller', location: 'delhi',
                          user_id: user1.id, category_id: Category.first.id, sub_category_id: Category.first.sub_categories.fourth.id, approved_by: admin.id)
image_paths = ['classical-guitar1.jpg', 'classical-guitar2.jpg', 'classical-guitar3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product2.images.attach(io: File.open(path), filename: image_path)
end

product3 = Product.create(title: 'Black Violin',
                          description: 'Black colour violin with case',
                          user_name: 'Gaurav', phone_number: '8999999964', price: '3000', role: 'Seller', location: 'Mumbai',
                          user_id: user1.id, category_id: Category.first.id, sub_category_id: Category.first.sub_categories.second.id, approved_by: admin.id)
image_paths = ['violin-1.jpg', 'violin-2.jpg', 'violin-3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product3.images.attach(io: File.open(path), filename: image_path)
end

product4 = Product.create(title: 'Best Cello',
                          description: 'Exquisite cello for sale - a masterpiece of craftsmanship, delivering rich, resonant tones that will captivate any audience.',
                          user_name: 'Mahfuz', phone_number: '8999999964', price: '2000', role: 'Buyer', location: 'pune',
                          user_id: user3.id, category_id: Category.first.id, sub_category_id: Category.first.sub_categories.third.id, approved_by: admin.id)
image_paths = ['cello-1.jpg', 'cello-2.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product4.images.attach(io: File.open(path), filename: image_path)
end

product5 = Product.create(title: ' Enchanting Harp for Sale',
                          description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                          user_name: 'Lokesh', phone_number: '8999999964', price: '3500', role: 'Buyer', location: 'patna',
                          user_id: user2.id, category_id: Category.first.id, sub_category_id: Category.first.sub_categories.fifth.id, approved_by: admin.id)
image_paths = ['Harp-1.jpg', 'Harp-2.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product5.images.attach(io: File.open(path), filename: image_path)
end

product6 = Product.create(title: 'Exceptional Keyboard Piano for Sale',
                          description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                          user_name: 'Lokesh', phone_number: '8999999967', price: '4000', role: 'Seller', location: 'kolkata',
                          user_id: user2.id, category_id: Category.second.id, sub_category_id: Category.second.sub_categories.first.id, approved_by: admin.id)
image_paths = ['piano-keyboard1.jpg', 'piano-keyboard2.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product6.images.attach(io: File.open(path), filename: image_path)
end

product7 = Product.create(title: 'Premium Digital Piano for Sale ',
                          description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                          user_name: 'Mahfuz', phone_number: '8999999965', price: '7000', role: 'Seller', location: 'patna',
                          user_id: user3.id, category_id: Category.first.id, sub_category_id: Category.second.sub_categories.second.id, approved_by: admin.id)
image_paths = ['Digital_piano1.jpg', 'Digital_piano2.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product7.images.attach(io: File.open(path), filename: image_path)
end

product8 = Product.create(title: 'Stylish Electronic Guitar',
                          description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                          user_name: 'Gaurav', phone_number: '8999999964', price: '5000', role: 'Buyer', location: 'patna',
                          user_id: user1.id, category_id: Category.first.id, sub_category_id: Category.second.sub_categories.third.id, approved_by: admin.id)
image_paths = ['electric-guitar1.jpg', 'electric-guitar2.jpg', 'electric-guitar3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product8.images.attach(io: File.open(path), filename: image_path)
end

product9 = Product.create(title: 'Traditional Tabla',
                          description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                          user_name: 'Gaurav', phone_number: '8999999964', price: '1000', role: 'Buyer', location: 'patna',
                          user_id: user1.id, category_id: Category.third.id, sub_category_id: Category.third.sub_categories.first.id, approved_by: admin.id)
image_paths = ['tabla-1.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product9.images.attach(io: File.open(path), filename: image_path)
end

product10 = Product.create(title: 'Best Drum-Set',
                           description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                           user_name: 'Mahfuz', phone_number: '8999999964', price: '5000', role: 'Seller', location: 'Mumbai',
                           user_id: user3.id, category_id: Category.third.id, sub_category_id: Category.third.sub_categories.second.id, approved_by: admin.id)
image_paths = ['Drum-1.jpg', 'Drum-2.jpg', 'Drum-3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product10.images.attach(io: File.open(path), filename: image_path)
end

product11 = Product.create(title: 'Traditional Dhol',
                           description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                           user_name: 'Lokesh', phone_number: '8999999964', price: '1500', role: 'Buyer', location: 'delhi',
                           user_id: user2.id, category_id: Category.third.id, sub_category_id: Category.third.sub_categories.third.id)
image_paths = ['Dhol-1.jpg', 'Dhol-2.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product11.images.attach(io: File.open(path), filename: image_path)
end

product12 = Product.create(title: 'Metal Flute',
                           description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                           user_name: 'Gaurav', phone_number: '8999999964', price: '7000', role: 'Seller', location: 'pune',
                           user_id: user1.id, category_id: Category.fourth.id, sub_category_id: Category.fourth.sub_categories.first.id, approved_by: admin)
image_paths = ['Flute-1.jpg', 'Flute-2.jpg', 'Flute-3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product12.images.attach(io: File.open(path), filename: image_path)
end

product13 = Product.create(title: 'Best Saxophone',
                           description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                           user_name: 'Lokesh', phone_number: '8999999964', price: '6500', role: 'Buyer', location: 'kolkata',
                           user_id: user2.id, category_id: Category.fourth.id, sub_category_id: Category.fourth.sub_categories.second.id, approved_by: admin.id)
image_paths = ['saxophone-1.jpg', 'saxophone-2.jpg', 'saxophone-3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product13.images.attach(io: File.open(path), filename: image_path)
end

product14 = Product.create(title: 'clarinet with case',
                           description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                           user_name: 'Mahfuz', phone_number: '8999999964', price: '5500', role: 'Buyer', location: 'parasnath',
                           user_id: user3.id, category_id: Category.fourth.id, sub_category_id: Category.fourth.sub_categories.third.id)
image_paths = ['clarinet-1.jpg', 'clarinet-2.jpg', 'clarinet-3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product14.images.attach(io: File.open(path), filename: image_path)
end

product15 = Product.create(title: 'Harmonium',
                           description: 'Immerse yourself in the ethereal beauty of this exquisite harp, meticulously handcrafted to produce heavenly melodies that transport listeners to a world of enchantment and wonder.',
                           user_name: 'Mahfuz', phone_number: '8999999964', price: '9500', role: 'Seller', location: 'pune',
                           user_id: user3.id, category_id: Category.fifth.id, sub_category_id: Category.fifth.sub_categories.first.id, approved_by: admin.id)
image_paths = ['Harmonium-1.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  product15.images.attach(io: File.open(path), filename: image_path)
end
