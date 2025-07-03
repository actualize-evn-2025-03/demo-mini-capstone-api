json.id carted_product.id
json.user_id carted_product.user_id
json.product_id carted_product.product_id
json.quantity carted_product.quantity
json.status carted_product.status
json.order_id carted_product.order_id
json.product do
  json.id carted_product.product.id
  json.name carted_product.product.name
  json.price carted_product.product.price
  json.description carted_product.product.description
  json.primary_image_url carted_product.product.primary_image_url
end 