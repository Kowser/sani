class User < ActiveRecord::Base
  # Include default devise modules. Others available are: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  # , :lockable

  def is_executive?
  	role == 'executive'
  end

  def is_administrator?
  	role == 'administrator'
  end
  
  def name
  	first_name + ' ' + last_name
  end
end
