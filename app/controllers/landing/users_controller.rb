class Landing::UsersController < LandingController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(role: User.roles['partner']))
    if @user.save
    	login(@user)
    	flash[:success] = "Welcome to Sani! - Please fill in your company information."
      redirect_to my_account_path
    else
      render 'new'
    end
  end
  
private
	def user_params
    params.require(:user).permit(Parameters::USER_PARAMS)
  end
end