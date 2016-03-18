class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
private
  def sign_in_dashboard_path
    if authorized?(:admin) && current_facility
    	dashboard_path(current_facility)
    elsif authorized?(:admin)
    	my_account_path
  	else
  		facility_maintenance_request_path(current_facility)
  	end
  end
end
