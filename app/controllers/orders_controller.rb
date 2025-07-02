class OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    @orders = current_user.orders
    # The exact same thing, just different syntax
    # @orders = Order.where(user_id: current_user.id)

    render json: @orders
  end

  def create
    # grab the carted products for this user where the status is carted
    carted_products = current_user.carted_products.where(status: "carted")

    # calculate the subtotal, tax, and total, based on the quantities from the carted product and the price of each product
    calculated_subtotal = 0

    carted_products.each do |carted_product|
      calculated_subtotal += carted_product.quantity * carted_product.product.price
    end

    calculated_tax = calculated_subtotal * 0.08
    calculated_total = calculated_tax + calculated_subtotal

    # create the order with the calculations and the user's id
    @order = Order.create(
      user_id: current_user.id,
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total
    )

    # update all of the user's carted products with the status of carted to be "purchased"
    carted_products.update_all(status: "purchased", order_id: @order.id)

    # render the order
    render json: @order
  end

  def show
    # @order = Order.find(params[:id])
    # @order = Order.find_by(id: params[:id])
    @order = current_user.orders.find_by(id: params[:id])
    # can use find, however, it throws a lot harsher errors
    # @order = current_user.orders.find(params[:id])

    if @order
      render json: @order
    else
      render json: { message: "Not your order..." }
    end
  end
end
