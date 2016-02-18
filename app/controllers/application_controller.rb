class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :access

  before_action :authenticate_user!
  before_action :select_facility, if: :user_signed_in?
  before_action :multiple_facilities, only: [:index], unless: :devise_controller?

  def after_sign_in_path_for(user)
  	select_facility # required here for @current_facility to be available
    if access(:admin)
      facility_dashboard_path(@current_facility)
    else
      facility_maintenance_requests_path(@current_facility)
    end
  end

# BEFORE_ACTIONS
  # loads facility & limits user access to their own facilities
  def select_facility
  	@current_facility = current_user.facilities.find_by(id: params[:facility_id]) || current_user.facilities.first
  end

  # shows selective if user manages multiple facilities
  def multiple_facilities
    @multiple_facilities = true if current_user.facilities.count > 1
  end

  # limits access in controllers
  def authorization(permitted_role)
    unless access(permitted_role)
      redirect_to after_sign_in_path_for(current_user)
      flash[:alert] = 'Your are not authorized.'
    end
  end

# HELPERS
  # limits access in views; utilized by controllers & views
  def access(permitted_role)
    current_user[:role] >= User.roles[permitted_role]
  end
end
