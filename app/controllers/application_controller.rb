class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
private
  def sign_in_dashboard_path
    if authorized?(:admin)
    	edit_user_path(current_user)
    	# dashboard_path(current_facility)
  	else
  		facility_maintenance_request_path(current_facility)
  	end
  end
end
