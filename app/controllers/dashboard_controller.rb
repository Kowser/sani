class DashboardController < ApplicationController
	before_action -> { authorization(:admin) }
	
	def index
		@employment_applications = @current_facility.employment_applications
		@maintenance_requests = @current_facility.maintenance_requests.completed
		@facilities = current_user.facilities.includes(:payments, :units, :residents)
			
		# MOVE THIS INTO A HELPER METHOD?
		@payments = {}
		upcoming_payments = @current_facility.invoices.upcoming_payments_this_month.pluck(:balance_due)
		@payments[:upcoming_payments] = upcoming_payments.inject(:+) || 0
		@payments[:upcoming_payments_count] = upcoming_payments.count || 0

		past_due_payments = @current_facility.invoices.past_due_payments.pluck(:balance_due)
		@payments[:past_due_payments] = past_due_payments.inject(:+) || 0
		@payments[:past_due_payments_count] = past_due_payments.count || 0
	end
end