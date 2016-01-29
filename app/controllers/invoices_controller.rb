class InvoicesController < ApplicationController
	def index
		@invoices = Invoice.all.includes(:resident => :unit).order('residents.first_name ASC')
	end

	def payments
		redirect_to action: 'index'
	end
private

	def payment_params
	  params.require(:invoices).permit(payments: [Parameters::PAYMENT_PARAMS])
	end
end