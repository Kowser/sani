class Dashboard::EmploymentApplicationsController < DashboardController
	before_action -> { authorization(:admin) }, only: [:index, :show, :update]
	# before_action :authenticate_user!, except: [:new, :create]

	# APPLICANT ACTIONS
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

	# FACILITY ACTIONS
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
	def employment_application_params
	  params.require(:employment_application).permit(Parameters::EMPLOYMENT_APPLICATION_PARAMS)
	end

	def staff_employment_application_params
		params.require(:employment_application).permit(Parameters::STAFF_EMPLOYMENT_APPLICATION_PARAMS)
	end
end