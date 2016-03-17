class DashboardController < ApplicationController
	# before_action :facility_selector, only: [:index]
	# before_action :authenticated_user!
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
	def authorize_user(role)
	  unless authorized?(role)
	    redirect_to after_sign_in_path_for(current_user)
	    flash[:alert] = 'Your are not authorized.'
	  end
	end
end