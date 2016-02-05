class MaintenanceRequestsController < ApplicationController
	def index
		@maintenance_requests = @current_facility.maintenance_requests
	end

	def new
		@maintenance_request = MaintenanceRequest.new
		render 'form'
	end

	def create
		@maintenance_request = @current_facility.maintenance_requests.build(maintenance_request_params)
		if @maintenance_request.save
			flash[:success] = 'Request successfully added to queue.'
			redirect_to action: 'index'
		else
			flash.now[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def edit
		@maintenance_request = @current_facility.maintenance_requests.find(params[:id])
		render 'form'
	end

	def update
		@maintenance_request = @current_facility.maintenance_requests.find(params[:id])
		if @maintenance_request.update(maintenance_request_params)
			flash[:success] = 'Request successfully updated.'
			redirect_to action: 'index'
		else
			flash.now[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

private
	def maintenance_request_params
		params.require(:maintenance_request).permit([Parameters::MAINTENANCE_REQUEST_PARAMS])
	end
end
