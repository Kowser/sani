class Dashboard::StaffController < DashboardController
	before_action -> { authorize_user(:admin) }
	
	def index
		@staff = current_facility.users.order('first_name ASC')
	end

	def new
		@staff = User.new
	end

	def create
	  @staff = User.new(staff_params)
	  if @staff.save
	  	current_facility.users << @staff
	    flash[:success] = 'Team Member added!'
	 		redirect_to action: 'new'
	  else
	  	flash[:alert] = 'Errors!'
	  	render 'new'
	  end
	end

	def edit
		@staff = User.find(params[:id])
	end

	def update
		@staff = current_facility.users.find(params[:id])
		if @staff.update(staff_params)
			flash[:success] = 'Staff member updated'
			redirect_to action: :index
		else
			flash[:alert] = "#{@staff.errors.full_messages.join(', ')}"
			render 'form'
		end
	end

	def find_staff
		email = params[:staff][:email]
		if @staff = User.find_by(email: email)
			render 'find_staff.js'
		else
			flash.now[:alert] = "User email #{email} doesn't appear to exist."
			render 'shared/errors.js'
		end
	end

private
	def staff_params
		params.require(:user).permit(Parameters::STAFF_PARAMS)
	end
end