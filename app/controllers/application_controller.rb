class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :select_facility, if: :user_signed_in?
  before_action :facility_selector, unless: :devise_controller?

  def after_sign_in_path_for(user)
  	select_facility
    facility_dashboard_path(@current_facility)
  end

  def select_facility
    # @facility = if id = params[:facility_id] || params[:id]
  	@current_facility = current_user.facilities.find_by(id: params[:facility_id]) || current_user.facilities.first
  	# else
  	# 	current_user.facilities.first
  	# end
  end

  def facility_selector
    @facility_selector = true
  end
end
