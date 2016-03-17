class Dashboard::UsersController < DashboardController
	# before_action :authenticate_user!, only: [:edit, :update]
  
  def edit
  end

  def update
  end

private
	def user_params
    params.require(:user).permit(Parameters::USER_PARAMS)
  end
end