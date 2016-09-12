class Image
  include Dynamoid::Document

  belongs_to :product
  field :name, :string
  field :large_url, :string
  field :small_url, :string
  field :description, :string
end