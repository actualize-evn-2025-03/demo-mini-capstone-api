class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images

  has_many :orders
end
