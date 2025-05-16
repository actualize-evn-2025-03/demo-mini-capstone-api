class ProductsController < ApplicationController
  def all_products
    products = Product.all

    render json: products
  end

  def first_product
    product = Product.find(1)

    render json: product
  end

  def second_product
    product = Product.find(2)

    render json: product
  end

  def third_product
    product = Product.find(3)

    render json: product
  end
end
