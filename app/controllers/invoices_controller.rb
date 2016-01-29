class InvoicesController < ApplicationController
	def index
		@invoices = Invoice.where("balance_due > 0").includes(:resident => :unit).order('residents.first_name ASC')
	end

	def payments
		payments = params[:invoices].delete_if { |k, v| v["amount"].to_f.zero? }
		puts payments.keys
		payments.keys.each do |invoice_id|
			i = Invoice.find(invoice_id)
			puts "\n\nHERE3: i.pmts.count:#{i.payments.count}\n"
			puts payments[invoice_id]
			i.payments.create!(payments[invoice_id])
			puts "\n\nHERE4: i.pmts.count:#{i.payments.count}\n"
		end
		redirect_to action: 'index'
	end
private

	def payment_params
	  params.require(:invoices).permit(payment: [Parameters::PAYMENT_PARAMS])
	end
end
