class FacilitiesController < ApplicationController
	def index
		@facilities = Facility.all
	end

	def new
		@facility = Facility.new
		render 'form'
	end

	def create
		@facility = Facility.new(facility_params)
		if @facility.save
			flash.now[:success] = 'Facility successfully added.'
			redirect_to action: 'index'
		else
			flash.now[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def edit
		@facility = Facility.find(params[:id])
		render 'form'
	end

	def update
		@facility = Facility.find(params[:id])
		if @facility.update(facility_params)
			flash.now[:success] = 'Facility successfully updated.'
			redirect_to action: 'index'
		else
			flash.now[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

private

	def facility_params
		params.require(:facility).permit(Parameters::FACILITY_PARAMS)
	end
end