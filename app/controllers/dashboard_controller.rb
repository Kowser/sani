class DashboardController < ApplicationController
	def home; end
	def billing
		@residents = Resident.all.order('unit ASC')
  end
end