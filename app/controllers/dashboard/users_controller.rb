class Dashboard::UsersController < DashboardController
  def update
    if current_user.update_attributes(user_params)
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