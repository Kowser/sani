class User < ActiveRecord::Base
  before_save { email.downcase! }
  has_secure_password
  enum role: { staff: 1, admin: 3, partner: 5, devops: 7 }
  
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :role, presence: { message: 'Error [Role], please contact system developer' }
  validates :password, presence: true, length: { minimum: 8}
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  has_and_belongs_to_many :facilities
  
  def name
    "#{first_name}  #{last_name}"
  end
end
