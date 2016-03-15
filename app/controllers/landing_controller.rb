class LandingController < ApplicationController
	before_action :authenticate_user!, except: [:home, :sign_up, :pricing, :contact_us]
	layout 'landing'

	def sign_up
		@user = User.new
	end

	def contact_us
		flash[:success] = 'Message sent! We\'ll get back to you shortly.'
		redirect_to :back
	end
end