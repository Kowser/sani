class StaffController < ApplicationController
	def index
		@staff = @current_facility.users.order('first_name ASC')
	end

	def new
		@staff = User.new
	end

	def find_staff
		email = params[:email][:email]
		if @staff = User.find_by(email: email)
			render 'find_staff.js'
		else
			flash.now[:alert] = "User email #{email} doesn't appear to exist."
			render 'shared/errors.js'
		end
	end

	def add_staff
		@staff = User.find(params[:staff][:id])
		@facility = Facility.first
		@facility.users << @staff
		flash.now[:success] = "User #{@staff.name} has been added to #{@facility.name}."

		redirect_to action: :new
	end

	def create
	  @staff = User.new(staff_params)
	  if @staff.save
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

	end

private
	def staff_params
		params.require(:staff).permit(Parameters::STAFF_PARAMS)
	end
end