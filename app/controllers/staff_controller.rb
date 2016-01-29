class StaffController < ApplicationController
	def index
		@staff = User.all.order('first_name ASC')
	end

	def new
		@staff = User.new
	end

	def create
	  @staff = User.new(staff_params.merge(role: 'Partner', staff_update: true))
	  @staff.organizations_users.build(organization: @current_profile)
	  if @staff.save
	    flash[:success] = 'Team Member added!'
	    redirect_to organization_staff_path(@current_profile)
	  else
	    flash.now[:alert] = fix_errors_message(@staff)
	    add_breadcrumb "STAFF", :organization_staff_path
	    add_breadcrumb "New Staff"
	    render 'new_staff_form'
	  end
	end

	def edit
		@staff = User.find(params[:id])
	end

	
end