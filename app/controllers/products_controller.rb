class ProductsController < ApplicationController
  def all_products
    products = Product.all

    render json: products
  end

  def products_show
    product = Product.find(params["id"])

    render json: product
  end
end
