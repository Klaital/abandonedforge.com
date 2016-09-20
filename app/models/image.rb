class Image < ApplicationRecord
  belongs_to :product
  has_many :image_tag, dependent: :destroy
end
