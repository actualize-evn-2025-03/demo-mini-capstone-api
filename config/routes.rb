Rails.application.routes.draw do
  get "/all_products" => "products#all_products"
  get "/first_product/:id" => "products#products_show"
end
