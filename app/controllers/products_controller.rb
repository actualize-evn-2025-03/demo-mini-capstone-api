class ProductsController < ApplicationController
  before_action :authenticate_admin, except: [ :index, :show ]

  def index
    @products = Product.all

    if params[:category]
      category = Category.find_by(name: params[:category])
      @products = category.products
    end

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
