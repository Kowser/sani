class Landing::UsersController < LandingController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(role: User.roles['partner']))
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def activation
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:token])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      login(user)
      flash[:success] = 'Account activated!'
      redirect_to my_account_path
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
  
private
	def user_params
    params.require(:user).permit(Parameters::USER_PARAMS)
  end
end