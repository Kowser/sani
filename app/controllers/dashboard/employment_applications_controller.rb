class Dashboard::EmploymentApplicationsController < DashboardController
	before_action -> { authorize_user(:admin) }

	def index
		@employment_applications = EmploymentApplication.all
	end

	def show
		@employment_application = EmploymentApplication.find(params[:id])
	end

	def update
		@employment_application = EmploymentApplication.find(params[:id])
		if @employment_application.update(staff_employment_application_params)
			redirect_to action: 'index'
		else
			flash[:alert] = 'Please fix the following errors'
			render 'form'
		end
	end
	
private
	def staff_employment_application_params
		params.require(:employment_application).permit(Parameters::STAFF_EMPLOYMENT_APPLICATION_PARAMS)
	end
end