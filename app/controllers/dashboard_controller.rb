class DashboardController < ApplicationController
	def home; end
	def billing
		@residents = Resident.all
  end

  def preferences; end
end