class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # authorization for controller actions/views
  # def authorized_user?(role)
  #   unless access(role)
  #     redirect_to after_sign_in_path_for(current_user)
  #     flash[:alert] = 'Your are not authorized.'
  #   end
  # end
  def authorization(role)
  	true
  end
end
