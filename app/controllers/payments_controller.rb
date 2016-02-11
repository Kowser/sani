class PaymentsController < ApplicationController
	def index
		@payments = @current_facility.payments.includes(:resident, :received_by)
	end

	def create_multiple
	end
end