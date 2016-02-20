class EmploymentApplicationsController < ApplicationController
	before_action -> { authorization(:admin) }

	def index
		@employment_applications = @current_facility.employment_applications
	end

	def new
		@employment_application = EmploymentApplication.new
		render 'form'
	end

	def create
		@employment_application = EmploymentApplication.new(employment_application_params.merge(facility: @current_facility))
		if @employment_application.save
			# FormsMailer.submit_application_email(@employment_application).deliver_now
			# send email to PV w/attachment
			redirect_to action: 'index'
		else
			flash[:alert] = 'Errors create'
			render 'form'
		end
	end

	def edit
		@employment_application = @current_facility.employment_applications.find(params[:id])
		render 'form'
	end

	def update
		@employment_application = @current_facility.employment_applications.find(params[:id])
		if @employment_application.save
			# FormsMailer.submit_application_email(@employment_application).deliver_now
			# send email to PV w/attachment
			redirect_to action: 'index'
		else
			flash[:alert] = 'Errors update'
			render 'form'
		end
	end

private

	def employment_application_params
	  params.require(:employment_application).permit(Parameters::EMPLOYMENT_APPLICATIONS)
	end
end