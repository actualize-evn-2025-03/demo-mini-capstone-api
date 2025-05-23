class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all

    render :index
  end

  def show
    @supplier = Supplier.find(params[:id])

    render :show
  end

  def create
    @supplier = Supplier.create(
      name: params[:name],
      email: params[:email],
      phone_number: params[:phone_number]
    )

    if @supplier.valid?
      render :show
    else
      render json: { errors: @supplier.errors.full_messages }
    end
  end
end
