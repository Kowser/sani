class InvoicesController < ApplicationController
	before_action -> { authorization(:admin) }
	
	def index
		@invoices = @current_facility.invoices.where("balance_due > 0")
			.order('residents.first_name ASC', 'invoices.due_date ASC')
			.includes(:resident => :unit)
	end

	def new
		@invoice = Invoice.new
		render 'form'
	end

	def create
		@invoice = Invoice.new(invoice_params)
		# FIX: Security issue - an invoice can be created for ANY resident at this point
		if @invoice.save
			flash[:success] = 'Invoice successfully saved.'
			redirect_to action: 'index'
		else
			flash[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def edit
		@invoice = @current_facility.invoices.find(params[:id])
		render 'form'
	end

	def update
		@invoice = @current_facility.invoices.find(params[:id])
		if @invoice.update(invoice_params)
			flash[:success] = 'Invoice successfully updated.'
			redirect_to action: 'index'
		else
			flash[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def destroy
		if invoice = @current_facility.invoices.find_by(id: params[:id])
			invoice.destroy
			flash[:alert] = "Invoice deleted."
		else
			flash[:alert] = 'That invoice doesn\'t appear to exist.'
		end
		redirect_to action: 'index'
	end

	def receive_payments
		payments = params[:invoices].reject { |k, v| v["amount"].to_f.zero? }
		invoices = @current_facility.invoices.where(id: payments.keys).includes(:resident)
		invoices.each do |invoice|
			Payment.create(payments["#{invoice.id}"].merge(resident_id: invoice.resident.id))
		end

		# Report.update(params[:report].keys, params[:report].values) # example of multiple update at once

		# puts payments.keys
		# payments.keys.each do |invoice_id|
		# 	i = Invoice.find(invoice_id)
		# 	puts "\n\nHERE3: i.pmts.count:#{i.payments.count}\n"
		# 	puts payments[invoice_id]
		# 	i.payments.create!(payments[invoice_id])
		# 	puts "\n\nHERE4: i.pmts.count:#{i.payments.count}\n"
		# end

		redirect_to action: 'index'
	end
private
	def payment_params
	  params.require(:invoices).permit(payment: [Parameters::PAYMENT_PARAMS])
	end

	def invoice_params
	  params.require(:invoice).permit(Parameters::INVOICE_PARAMS)
	end
end
