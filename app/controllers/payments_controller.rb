class PaymentsController < ApplicationController
	def index
		@payments = @current_facility.payments.includes(:resident)
	end

	def create_multiple
	end
end