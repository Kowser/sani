class Dashboard::FacilitiesController < DashboardController
	skip_before_action :facility_selector, only: :index
	before_action -> { authorize_user(:partner) }

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
		if @facility = current_user.facilities.includes(:units, :residents).find_by(id: params[:id])
			render 'form'
		else
			flash[:alert] = 'That facility does not exist'
			redirect_to action: 'index'
		end
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