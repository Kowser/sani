
class Dashboard::EmploymentApplicationsController < DashboardController
	def new
		@employment_application = EmploymentApplication.new
		render 'form'
	end

	def create
		@employment_application = EmploymentApplication.new(employment_application_params.merge(facility: current_facility))
		if @employment_application.save
			# FormsMailer.submit_application_email(@employment_application).deliver_now
			# send email to PV w/attachment
			render 'thank_you'
		else
			flash[:alert] = 'Please fix the following errors'
			render 'form'
		end
	end
	
private
	def employment_application_params
	  params.require(:employment_application).permit(Parameters::EMPLOYMENT_APPLICATION_PARAMS)
	end
end