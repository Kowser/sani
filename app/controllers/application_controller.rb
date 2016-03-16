class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  layout 'dashboard'



# ------------------------------------------

  before_action :facility_selector?, only: [:index]
  helper_method :access
  # before_action :select_facility

# BEFORE_ACTIONS
  # loads facility & limits user access to assigned facilities
  # def select_facility
  # 	@current_facility ||= (current_user.facilities.find_by(id: params[:facility_id]) || current_user.facilities.first)
  # end

  # shows selector for users associated with multiple facilities
  def facility_selector?
    @selector = current_user.facilities.count > 1
  end

  # authorization for controller actions/views
  # def authorization(role)
  #   unless access(role)
  #     redirect_to after_sign_in_path_for(current_user)
  #     flash[:alert] = 'Your are not authorized.'
  #   end
  # end

# HELPERS
  # authorization utilized by controllers & views
  def access(role)
    current_user[:role] >= User.roles[role]
    true
  end
end
