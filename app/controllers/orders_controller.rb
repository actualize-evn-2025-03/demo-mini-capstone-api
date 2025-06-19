class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
    # The exact same thing, just different syntax
    # @orders = Order.where(user_id: current_user.id)

    render json: @orders
  end

  def create
    product = Product.find(params[:product_id])

    subtotal = product.price * params[:quantity].to_i
    tax = subtotal * 0.08
    total = tax + subtotal

    @order = Order.new(
      quantity: params[:quantity],
      subtotal: subtotal,
      tax: tax,
      total: total,
      user_id: current_user.id,
      product_id: params[:product_id]
    )

    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :bad_request
    end
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
