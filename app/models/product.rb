class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :category_products
  has_many :categories, through: :category_products

  # def categories
  #   category_products.map do |category_product|
  #     category_product.category
  #   end
  # end
end
