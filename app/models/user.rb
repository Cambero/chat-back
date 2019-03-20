class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  field :username, type: String
  field :password_digest, type: String

  validates :username, presence:true, uniqueness: true

  has_many :rooms

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    user && user.authenticate(password)
  end
end
