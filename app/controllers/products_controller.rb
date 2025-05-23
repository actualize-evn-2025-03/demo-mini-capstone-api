class ProductsController < ApplicationController
  def index
    @products = Product.all

    render :index
  end

  def show
    @product = Product.find(params["id"])

    render :show
  end

  def create
    @product = Product.create(
      name: params["name"],
      price: params["price"],
      description: params["description"],
      supplier_id: params["supplier_id"]
    )

    if @product.valid?
      render :show
    else
      render json: { errors: @product.errors.full_messages }
    end
  end
end
