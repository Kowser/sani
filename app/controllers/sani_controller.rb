class SaniController < ApplicationController
	before_action :authenticate_user!, except: [:contact_us]

	def contact_us
		flash[:success] = 'Message sent! We\'ll get back to you shortly.'
		redirect_to :back
	end
end