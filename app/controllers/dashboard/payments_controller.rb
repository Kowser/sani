class Dashboard::PaymentsController < DashboardController
	before_action -> { authorize_user(:admin) }
	before_action :facility_selector, only: [:deposit_payments, :receive_payments]

	def deposit_payments # combine under index later with params?
		@payments = current_facility.payments.where(search_params).includes(:resident)
		@default_selected = search_params.values.first
		# binding.pry
	end

	def receive_payments # combine under index later with params?
		@residents = current_facility.residents.where(active: true).order_by_name
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

	def create_many
		current_facility.residents.update(new_payment_params[:resident_ids].keys, new_payment_params[:resident_ids].values )
		redirect_to action: 'receive_payments'
	end

	def edit
		@payment = current_facility.payments.find(params[:id])
		render 'form'
	end

	def update
		@payment = current_facility.payments.find(params[:id])
		if @payment.update(payment_params)
			flash[:success] = 'Payment successfully updated.'
			redirect_to action: 'deposit_payments'
		else
			flash[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def update_many
		current_facility.payments.update(deposit_params[:deposit_fields].keys, deposit_params[:deposit_fields].values)
		redirect_to :back
	end

	def destroy
		if payment = current_facility.payments.find_by(id: params[:id])
			payment.destroy
			flash[:alert] = "Payment deleted."
			redirect_to action: 'deposit_payments'
		else
			flash[:alert] = 'That payment doesn\'t appear to exist.'
		end
	end

private
	def payment_params
	  params.require(:payment).permit(Parameters::PAYMENT_PARAMS)
	end

	def deposit_params
		params.require(:deposits).permit(deposit_fields: [:deposited])
	end

	def new_payment_params
		params.require(:residents).permit(resident_ids: [payments_attributes: [:amount, :method, :receive_date]])
	end

	def search_params
	  params[:search] ? params.require(:search).permit(:deposited) : { deposited: false }
	end
end