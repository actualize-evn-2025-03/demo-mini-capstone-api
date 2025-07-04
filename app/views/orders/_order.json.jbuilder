json.id order.id
json.user_id order.user_id
json.subtotal order.subtotal
json.tax order.tax
json.total order.total
json.carted_products order.carted_products do |carted_product|
  json.id carted_product.id
  json.quantity carted_product.quantity
  json.product do
    json.id carted_product.product.id
    json.name carted_product.product.name
    json.price carted_product.product.price
    json.description carted_product.product.description
    json.primary_image_url carted_product.product.primary_image_url
  end
end 
