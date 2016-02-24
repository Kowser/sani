class DashboardController < ApplicationController
	before_action -> { authorization(:admin) }
	
	def index
		@facilities = current_user.facilities.includes(:payments, :units, :residents)
		@maintenance_requests = @current_facility.maintenance_requests.completed_this_week
		
		# update to show only NEW applications
		@employment_applications = EmploymentApplication.all
	end
end