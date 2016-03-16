class LandingController < ApplicationController
	skip_before_action :select_facility
	layout 'landing'

	def contact_us
		flash[:success] = 'Message sent! We\'ll get back to you shortly.'
		redirect_to :back
	end
end