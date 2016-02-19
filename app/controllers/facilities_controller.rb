class FacilitiesController < ApplicationController
	before_action -> { authorization(:partner) }

	def index
		@facilities = current_user.facilities
		@show_facility_selector = false
	end

	def new
		@facility = Facility.new
		@facility.units.build
		render 'form'
	end

	def create
		@facility = current_user.facilities.build(facility_params.merge(owner: current_user))
		if @facility.save
			@facility.users << current_user
			flash.now[:success] = 'Facility successfully added.'
			redirect_to action: 'index'
		else
			flash.now[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def edit
		@facility = current_user.facilities.find(params[:id])
		render 'form'
	end

	def update
		@facility = current_user.facilities.find(params[:id])
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