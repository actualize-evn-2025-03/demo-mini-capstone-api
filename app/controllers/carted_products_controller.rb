class CartedProductsController < ApplicationController
  def index
    @carted_products = current_user.carted_products.where(status: "carted").includes(:product)

    render :index
  end

  def create
    @carted_product = CartedProduct.create(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted"
    )

    render :create
  end

  def destroy
    @carted_product = current_user.carted_products.find_by(id: params[:id])

    @carted_product.update(status: "removed")

    render json: { message: "Product was removed from the cart" }
  end
end
