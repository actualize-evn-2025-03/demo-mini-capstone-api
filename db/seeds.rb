# db/seeds.rb
# ------------------------------------------------------------------
# Populates:
#   • 1 admin + 10 regular users
#   • 3 suppliers
#   • 10 categories
#   • 50 products (each with 1-3 images and 1-3 categories)
#   • 100 orders (random users & products, qty 1-5)
#
# Requires faker. If it isn’t in your Gemfile yet, add:
#   gem "faker", "~> 3.4"
# then: bundle install
# ------------------------------------------------------------------

require "faker"
require "bigdecimal/util"

TAX_RATE = 0.05 # 5 %

puts "\n🌱  Resetting tables…"
[Image, CategoryProduct, Category, CartedProduct, Order,
 Product, Supplier, User].each(&:delete_all)

# ---------------------------- Users -------------------------------
puts "🔑  Creating users…"
admin = User.create!(
  name:  "Admin User",
  email: "admin@example.com",
  password:              "password",
  password_confirmation: "password",
  admin: true
)

10.times do
  User.create!(
    name:  Faker::Name.name,
    email: Faker::Internet.unique.email,  # works on any Faker version
    password:              "password",
    password_confirmation: "password"
  )
end

# -------------------------- Suppliers -----------------------------
puts "🏭  Creating suppliers…"
3.times do
  Supplier.create!(
    name:         Faker::Company.unique.name,
    email:        Faker::Internet.unique.email,
    phone_number: Faker::PhoneNumber.phone_number
  )
end
suppliers = Supplier.all

# -------------------------- Categories ----------------------------
puts "🏷️   Creating categories…"
category_names = %w[
  Apparel Electronics Books Home Beauty Toys
  Sports Grocery Automotive Garden
]
categories = category_names.map { |n| Category.create!(name: n) }

# --------------------------- Products -----------------------------
puts "📦  Creating products, images & tags…"
50.times do
  product = Product.create!(
    name:        Faker::Commerce.unique.product_name,
    description: Faker::Lorem.sentence(word_count: 12),
    price:       Faker::Commerce.price(range: 5..200).round, # integer dollars
    supplier:    suppliers.sample
  )

  # 1-3 placeholder images
  rand(1..3).times do
    Image.create!(
      url: "https://picsum.photos/seed/#{SecureRandom.hex(4)}/400/400",
      product: product
    )
  end

  # tag with 1-3 categories
  categories.sample(rand(1..3)).each do |cat|
    CategoryProduct.create!(product: product, category: cat)
  end
end
products = Product.all

# ---------------------------- Orders ------------------------------
puts "🧾  Creating orders…"
users = User.where(admin: false)

100.times do
  user = users.sample
  
  # Create 1-3 carted products for this order
  carted_products = []
  rand(1..3).times do
    product = products.sample
    quantity = rand(1..5)
    
    carted_products << CartedProduct.create!(
      user: user,
      product: product,
      quantity: quantity,
      status: "purchased"
    )
  end
  
  # Calculate totals for the order
  subtotal = carted_products.sum { |cp| (cp.product.price * cp.quantity).to_d }
  tax = (subtotal * TAX_RATE).round(2)
  total = subtotal + tax
  
  # Create the order
  order = Order.create!(
    user: user,
    subtotal: subtotal,
    tax: tax,
    total: total
  )
  
  # Associate the carted products with the order
  carted_products.each do |cp|
    cp.update!(order: order)
  end
end

# --------------------------- Summary ------------------------------
puts "\n✅  Seeding complete!"
puts "   Users:         #{User.count} (#{User.where(admin: true).count} admin)"
puts "   Suppliers:     #{Supplier.count}"
puts "   Categories:    #{Category.count}"
puts "   Products:      #{Product.count}"
puts "   Images:        #{Image.count}"
puts "   Orders:        #{Order.count}"
puts "   Cart Items:    #{CartedProduct.count}"

# If you ever need to reuse Faker’s unique generators elsewhere:
#   Faker::UniqueGenerator.clear
