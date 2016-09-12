class User
  include Dynamoid::Document

  field :name, :string
  field :email, :string
  field :password, :string
  has_many :products
end
