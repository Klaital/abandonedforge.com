class Product
  include Dynamoid::Document

  field :name, :string
  field :launch_date, :datetime
  field :blade_material, :string
  field :handle_material, :string
  field :tags, :set
  field :blade_length, :integer
  field :overall_length, :integer
  field :description, :string
  has_many :images
  belongs_to :user


end