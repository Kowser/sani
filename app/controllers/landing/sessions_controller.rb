class Landing::SessionsController < LandingController
	def new
		flash.now[:alert] = 'You are already signed in.' if logged_in?
	end

	def create
		@user = User.find_by(email: session_params[:email].downcase)
		if @user && @user.authenticate(session_params[:password])
			if @user.activated?
			  login(@user)
			  session_params[:remember_me] == '1' ? remember(@user) : forget(@user)
			  redirect_back_or sign_in_dashboard_path
			else
			  flash[:warning] = 'Account not activated: Check your email for the activation link.'
			  redirect_to root_url
			end
		else
			flash[:alert] = 'Invalid email/password combination.'
			redirect_to action: 'new'
		end
	end

	def destroy
    logout if logged_in?
    redirect_to root_url
  end

private
	def session_params
		params.require(:session).permit(:email, :password, :remember_me)
	end
end

