class MigrateImageUrlToImagesTable < ActiveRecord::Migration[8.0]
  def up
    Product.find_each do |product|
      if product.image_url.present?
        Image.create!(product_id: product.id, url: product.image_url)
      end
    end
  end

  def down
    Image.find_each do |image|
      product = Product.find_by(id: image.product_id)
      next unless product && product.image_url.blank?

      product.update!(image_url: image.url)
    end
  end
end
