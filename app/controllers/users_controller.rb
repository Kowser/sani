class UsersController < ApplicationController
	# before_action :authenticate_user!, only: [:edit, :update]

  def new
    @user = User.new
    render layout: 'landing'
  end

	def create
    @user = User.new(user_params.merge(role: User.roles['partner']))
    if @user.save
    	login(@user)
    	flash[:success] = "Welcome to Sani - Please fill in your company information."
      redirect_to edit_user_path(current_user)
    else
      render 'new', layout: 'landing'
    end
  end

  def edit
  end

private

	def user_params
    params.require(:user).permit(Parameters::USER_PARAMS)
  end
end