class SaniController < ApplicationController
	before_action :authenticate_user!, except: [:home, :sign_up, :contact_us]
	layout 'landing'

	def home;	end
	def sign_up; end

	def contact_us
		flash[:success] = 'Message sent! We\'ll get back to you shortly.'
		redirect_to :back
	end
end