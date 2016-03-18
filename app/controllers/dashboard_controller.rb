class DashboardController < ApplicationController
	before_action :authenticate_user
	before_action :facility_selector, only: [:index]
	layout 'dashboard'
	
	# Dashboard landing page
	def index
		authorize_user(:admin)
		@facilities = current_user.facilities.includes(:payments, :units, :residents)
		@maintenance_requests = current_facility.maintenance_requests.completed_this_week
		# update to show only NEW applications
		@employment_applications = EmploymentApplication.all
	end

private
	# Confirms a signed-in user.
  def authenticate_user
    unless logged_in?
    	store_location
      flash[:danger] = 'You must sign in first.'
      redirect_to sign_in_path
    end
  end

  # Confirms an authorized user.
	def authorize_user(role)
	  unless authorized?(role)
	    flash[:alert] = 'Your are not authorized.'
	    redirect_to after_sign_in_path_for(current_user)
	  end
	end
end