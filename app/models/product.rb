class Product < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :product_material, dependent: :destroy
  belongs_to :user
end

