class InvoicesController < ApplicationController
	def index
		if request.post?

		else
			@invoices = Invoice.where("balance_due > 0").includes(:resident => :unit).order('residents.first_name ASC')
		end
	end

	def payments
		redirect_to action: 'index'
	end
private

	def payment_params
	  params.require(:invoices).permit(payments: [Parameters::PAYMENT_PARAMS])
	end
end
