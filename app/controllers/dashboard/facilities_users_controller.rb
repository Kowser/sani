class Dashboard::FacilitiesUsersController < DashboardController
	before_action -> { authorize_user(:admin) }

	def create
		add_staff = FacilitiesUser.new(facility: current_facility, user_id: params[:user_id])
		if add_staff.save
			flash[:success] = "#{params[:name]} has been added to #{current_facility.name} staff."
		else
			flash[:alert] = "#{add_staff.errors.full_messages.join(', ')}"
		end

		redirect_to facility_staff_index_url(current_facility)
	end

	def destroy
		@staff = current_facility.users.find(params[:id])
		staff_remove = FacilitiesUser.find_by(facility: current_facility, user: @staff)
		if staff_remove.destroy
			flash[:success] = "#{@staff.name} has been removed from #{current_facility.name} staff."
		else
			flash[:alert] = "#{staff_remove.errors.full_messages.join(', ')}"
		end

		redirect_to facility_staff_index_url(current_facility)
	end
end