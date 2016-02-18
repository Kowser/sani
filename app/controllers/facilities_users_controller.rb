class FacilitiesUsersController < ApplicationController
	before_action -> { authorization(:admin) }

	def create
		@add_staff = FacilitiesUser.new(facility: @current_facility, user_id: params[:user_id])
		if @add_staff.save
			flash[:success] = "#{params[:name]} has been added to #{@current_facility.name} staff."
		else
			flash[:alert] = "#{@add_staff.errors.full_messages.join(', ')}"
		end

		redirect_to facility_staff_index_url(@current_facility)
	end

	def destroy
		@staff = @current_facility.users.find(params[:id])
		@remove_staff = FacilitiesUser.find_by(facility: @current_facility, user: @staff)
		if @remove_staff.destroy
			flash[:success] = "#{@staff.name} has been removed from #{@current_facility.name} staff."
		else
			flash[:alert] = "#{@remove_staff.errors.full_messages.join(', ')}"
		end

		redirect_to facility_staff_index_url(@current_facility)
	end
end