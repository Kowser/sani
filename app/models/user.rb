class User < ActiveRecord::Base
  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  # , :lockable

  validates_presence_of :email, :first_name, :last_name, :role
  has_and_belongs_to_many :facilities

  def is_executive?
  	role == 'Executive'
  end

  def is_administrator?
  	role == 'Administrator'
  end

  def is_staff?
    role == 'Staff'
  end
  
  def name
  	first_name + ' ' + last_name
  end
end
