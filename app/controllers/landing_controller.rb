class LandingController < ApplicationController
	before_action :authenticate_user!, except: [:home, :sign_up, :contact_us]
	layout 'landing'

	def contact_us
		flash[:success] = 'Message sent! We\'ll get back to you shortly.'
		redirect_to :back
	end
end