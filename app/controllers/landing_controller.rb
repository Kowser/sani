class LandingController < ApplicationController
	layout 'landing'

	def contact_us
		flash[:success] = 'Message sent! We\'ll respond shortly.'
		redirect_to :back
	end
end