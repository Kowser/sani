class ResidentsController < ApplicationController
	before_action :find_tenant, only: [:dashboard, :contact_us]

	def dashboard; end
	def contact_us; end
	def settings; end

private
	def find_tenant
		# replace with current_user later in views
		@resident = User.first
	end
end