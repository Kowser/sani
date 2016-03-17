class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save { email.downcase! }
  has_secure_password
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :role, presence: { message: 'Error [Role], please contact system developer.' }
  validates :password, presence: true, length: { minimum: 8}, allow_nil: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  enum role: { staff: 1, admin: 3, partner: 5, devops: 7 }

  has_and_belongs_to_many :facilities
  
  def name
    "#{first_name}  #{last_name}"
  end

# AUTHENTICATION METHODS ----------------------------------------------------------------------------
  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
# END AUTHENTICATION METHODS -------------------------------------------------------------------------
end
