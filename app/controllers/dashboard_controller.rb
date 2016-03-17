class DashboardController < ApplicationController
	before_action :facility_selector, only: [:index]
	# before_action :authenticated_user?
	layout 'dashboard'
	
	# Dashboard landing page
	def index
		authorization(:admin)
		@facilities = current_user.facilities.includes(:payments, :units, :residents)
		@maintenance_requests = current_facility.maintenance_requests.completed_this_week
		
		# update to show only NEW applications
		@employment_applications = EmploymentApplication.all
	end
end