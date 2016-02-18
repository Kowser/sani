class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :select_facility, if: :user_signed_in?
  before_action :show_facility_selector, only: [:index], unless: :devise_controller?


  def after_sign_in_path_for(user)
  	select_facility # required here for @current_facility to be available
    facility_dashboard_path(@current_facility)
  end

  # loads facility & helps ensure user can only view their own facilities
  def select_facility
  	@current_facility = current_user.facilities.find_by(id: params[:facility_id]) || current_user.facilities.first
  end

  # only shows selective if user manages multiple facilities
  def show_facility_selector
    @show_facility_selector = true if current_user.facilities.count > 1
  end
end
