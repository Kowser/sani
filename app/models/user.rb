class User < ActiveRecord::Base
  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  # , :lockable

  # Rails 4.1+, allows roles & their corresponding methods .staff?, .admin?, user[:role] = #, etc...
  # visit http://railsapps.github.io/rails-authorization.html for more information
  enum role: {staff: 1, admin: 3, exec: 5, devops: 7} # please do not define 0

  validates_presence_of :email, :first_name, :last_name, :role
  has_and_belongs_to_many :facilities

  
  def name
  	first_name + ' ' + last_name
  end
end
