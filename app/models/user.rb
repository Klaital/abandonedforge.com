class User
  include Dynamoid::Document
  include BCrypt

  field :name, :string
  field :email, :string
  field :password_digest, :string
  has_many :products

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#  validates :email, presence: true, length: { maximum: 255 },
#            format: { with: VALID_EMAIL_REGEX },
#            uniqueness: { case_sensitive: false }

  def password=(new_password)
    # self.password_digest = Password.create(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
  def password
    #self.password_digest
    @password ||= Password.new(self.password_digest)
  end
  def authenticate(given_password)
    return self.password == given_password
  end
end
