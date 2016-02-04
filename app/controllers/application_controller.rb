class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :select_facility, if: :user_signed_in?
  before_action :show_facility_selector, only: [:index], unless: :devise_controller?

  def after_sign_in_path_for(user)
  	select_facility
    facility_dashboard_path(@current_facility)
  end

  def select_facility
  	@current_facility = current_user.facilities.find_by(id: params[:facility_id]) || current_user.facilities.first
  end

  def show_facility_selector
    @show_facility_selector = true if current_user.facilities.count > 1
    # only show if user manages multiple facilities
  end
end
