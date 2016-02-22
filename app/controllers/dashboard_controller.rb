class DashboardController < ApplicationController
	before_action -> { authorization(:admin) }
	
	def index
		@employment_applications = @current_facility.employment_applications
		@maintenance_requests = @current_facility.maintenance_requests.completed
		@facilities = current_user.facilities.includes(:payments, :units, :residents)
	end
end