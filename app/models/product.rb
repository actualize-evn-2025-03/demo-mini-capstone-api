class Product < ApplicationRecord
  def supplier
    Supplier.find_by(id: supplier_id)
  end
end
