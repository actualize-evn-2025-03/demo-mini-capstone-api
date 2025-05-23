class ImagesController < ApplicationController
  def index
    @images = Image.all

    render :index
  end

  def show
    @image = Image.find(params[:id])

    render :show
  end

  def create
    @image = Image.create(
      url: params[:url],
      product_id: params[:product_id]
    )

    if @image.valid?
      render :show
    else
      render json: { errors: @image.errors.full_messages }
    end
  end
end
