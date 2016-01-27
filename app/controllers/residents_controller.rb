class ResidentsController < ApplicationController
	def index
		@residents = Resident.all
	end

	def new
		@resident = Resident.new
		render 'form'
	end

	def create
		@resident = Resident.new(resident_params)
		if @resident.save
			flash.now[:success] = 'Resident successfully added to roster.'
			redirect_to action: 'index'
		else
			flash.now[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def edit
		@resident = Resident.find(params[:id])
		render 'form'
	end

	def update
		@resident = Resident.find(params[:id])
		if @resident.update(resident_params)
			flash.now[:success] = 'Resident successfully updated.'
			redirect_to action: 'index'
		else
			flash.now[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end
private

	def resident_params
	  params.require(:resident).permit(Parameters::RESIDENT_PARAMS)
	end
end
