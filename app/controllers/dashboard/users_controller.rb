class Dashboard::UsersController < DashboardController
	# before_action :authenticate_user!, only: [:edit, :update]
  
  def edit
  	@user = User.find(params[:id])
  	# @user = current_user
  end

  def update
  	@user = User.find(params[:id])
  	# @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = 'Account updated successfully.'
      redirect_to sign_in_dashboard_path
    else
      render 'edit'
    end
  end

private
	def user_params
    params.require(:user).permit(Parameters::USER_PARAMS)
  end
end