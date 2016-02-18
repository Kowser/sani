class PaymentsController < ApplicationController
	before_action -> { authorization(:admin) }

	def index
		@payments = @current_facility.payments.where(deposited: false).includes(:resident)
		# @payments = @current_facility.payments.includes(:resident)
	end

	def new
		@payment = Payment.new
		render 'form'
	end

	def create
		@payment = Payment.new(payment_params)
		# FIX: Security issue - a payment can be created for ANY resident at this point
		if @payment.save
			flash[:success] = 'Payment saved.'
			redirect_to action: 'index'
		else
			flash[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def edit
		@payment = @current_facility.payments.find(params[:id])
		render 'form'
	end

	def update
		@payment = @current_facility.payments.find(params[:id])
		if @payment.update(payment_params)
			flash[:success] = 'Payment successfully updated.'
			redirect_to action: 'index'
		else
			flash[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def destroy
		if payment = @current_facility.payments.find_by(id: params[:id])
			payment.destroy
			flash[:alert] = "Payment deleted."
		else
			flash[:alert] = 'That payment doesn\'t appear to exist.'
		end
		redirect_to action: 'index'
	end

	def deposit_payments
		deposit_ids = params[:deposits].select { |k, v| v['deposited'] == '1' }.keys
		if deposit_ids.any?
			@current_facility.payments.update(deposit_ids, params[:deposits].values)
			flash[:success] = "Deposited #{ActionController::Base.helpers.pluralize(deposit_ids.count, 'payment')}."
			# date = params[:date].blank? ? Date.today : params[:date] # move to model?
			# @current_facility.payments.where(id: deposit_ids).update_all(deposited: true, deposit_date: date)
		else
			flash[:alert] = 'No payments selected.'
		end
		redirect_to action: 'index'
	end

private
	def payment_params
	  params.require(:payment).permit(Parameters::PAYMENT_PARAMS)
	end
end