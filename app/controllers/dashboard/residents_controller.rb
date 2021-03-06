class Dashboard::ResidentsController < DashboardController
	before_action -> { authorize_user(:staff) }, only: [:index, :edit]
	before_action -> { authorize_user(:admin) }, only: [:new, :create, :update]

	def index
		@residents = current_facility.residents.includes(:unit)
		#this should only be active residents only. Default or create a scope?
	end

	def new
		@resident = Resident.new
		render 'form'
	end

	def create
		@resident = current_facility.residents.new(resident_params)
		if @resident.save
			flash[:success] = 'Resident successfully added.'
			redirect_to action: 'index'
		else
			flash[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end

	def edit
		@resident = current_facility.residents.find(params[:id])
		render 'form'
	end

	def update
		@resident = current_facility.residents.find(params[:id])
		if @resident.update(resident_params)
			flash[:success] = 'Resident successfully updated.'
			redirect_to action: 'index'
		else
			flash[:alert] = 'Please fix the following errors.'
			render 'form'
		end
	end
private

	def resident_params
	  params.require(:resident).permit(Parameters::RESIDENT_PARAMS)
	end
end
