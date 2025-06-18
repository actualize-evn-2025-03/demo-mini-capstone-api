# db/seeds.rb
puts "🌱  Seeding…"

# ---- Helpers --------------------------------------------------------------

def cents(amount)
  # Convert a String or Float in dollars (e.g. "2.99") to an Integer in cents
  (BigDecimal(amount.to_s) * 100).to_i
end

# ---- Wipe existing data ---------------------------------------------------

Image.destroy_all
Product.destroy_all
Supplier.destroy_all

# ---- Suppliers ------------------------------------------------------------

amazon     = Supplier.create!(name: "Amazon",      email: "amazon@email.com",     phone_number: "243222342")
think_geek = Supplier.create!(name: "Think Geek",  email: "thinkgeek@email.com",  phone_number: "5432534")

# ---- Products + Images ----------------------------------------------------

products = [
  {
    supplier: think_geek,
    name: "WNYX Mug",
    price: cents(2.99),
    description: "Get your morning news once you wake up with a cup of joe from... well Joe. He made it with his homemade duct tape",
    image_url: "http://s32.postimg.org/6mceui22t/wnyx_mug.png"
  },
  {
    supplier: think_geek,
    name: "Hitchhiker's Guide to the Galaxy",
    price: cents(42.00),
    description: "In many of the more relaxed civilizations on the Outer Eastern Rim of the Galaxy, the Hitch-Hiker's Guide has already supplanted the great Encyclopaedia Galactica as the standard repository of all knowledge and wisdom …",
    image_url: "http://www.notcot.com/images/guide.gif"
  },
  {
    supplier: think_geek,
    name: "Lightsaber",
    price: cents(270.10),
    description: "Part laser, part samurai sword, all awesome. The lightsaber is an elegant weapon for a more civilized age, not nearly as clumsy as a blaster",
    image_url: "http://25.media.tumblr.com/d2456964024018fd930338c099371104/tumblr_n2m73lTx2Q1svn82uo1_400.gif"
  },
  {
    supplier: amazon,
    name: "Space Cowboy Laser Gun",
    price: cents(170.00),
    description: "This weapon has no other description than, Shiny!",
    image_url: "http://cdn.shopify.com/s/files/1/0289/1534/products/MalPistol_MP-1_1756x988_e53f9448-81ec-41de-9369-4cbad64f18f5_1024x1024.jpg?v=1401915776"
  },
  {
    supplier: think_geek,
    name: "DnD Dice set",
    price: cents(57.50),
    description: "Take down mighty dragons with this timeless set of 20-sided wonders",
    image_url: "https://s-media-cache-ak0.pinimg.com/736x/9c/15/7b/9c157bea5331463f9c539cbce739a4b8.jpg"
  },
  {
    supplier: amazon,
    name: "Sonic Screwdriver",
    price: cents(9.99),
    description: "The Doctor's science-y magic wand to get out of tight spots. Note: does not work on wood",
    image_url: "https://sketchfab.com/blogs/community/wp-content/uploads/2020/04/image2-2.jpg"
  },
  {
    supplier: think_geek,
    name: "Yoda sleeping bag",
    price: cents(40.00),
    description: "For real",
    image_url: "https://staticdelivery.nexusmods.com/mods/1151/images/12353-0-1461721930.png"
  }
]

products.each do |attrs|
  img_url = attrs.delete(:image_url)
  product = Product.create!(attrs)
  Image.create!(url: img_url, product: product)
end

puts "✅  Done!"
