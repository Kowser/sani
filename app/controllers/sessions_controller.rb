class SessionsController < ApplicationController
	skip_before_action :select_facility
	layout 'landing'

	def create
		user = User.find_by(email: session_params[:email].downcase)
		if user && user.authenticate(session_params[:password])
			login(user)
			redirect_to edit_user_path(user)
		else
			flash[:alert] = 'Invalid email/password combination.'
			redirect_to action: 'new'
		end
	end

	def destroy
    logout
    redirect_to root_url
  end

private
	def session_params
		params.require(:session).permit(:email, :password)
	end
end

