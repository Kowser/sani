class ContactsController < ApplicationController
	before_action :authenticate_user!, except: [:create]

	def create
		flash[:success] = 'Message sent! We\'ll get back to you shortly.'
		redirect_to :back
	end
end