class UsersController < ApplicationController
	# before_action :authenticate_user!, only: [:edit, :update]
	skip_before_action :select_facility
	# , only: [:create]

	def create
    @user = User.new(user_params.merge(role: User.roles['partner']))
    if @user.save
    	# sign in user
    	flash[:success] = "Welcome to Sani - Please fill in your company information."
      redirect_to edit_user_path(@user)
    else
      render 'landing/sign_up', layout: 'landing'
    end
  end

  def edit
  end

private

	def user_params
    params.require(:user).permit(Parameters::USER_PARAMS)
  end
end