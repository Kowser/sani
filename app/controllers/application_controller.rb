class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    if user.is_resident?
      residents_dashboard_path
    elsif user.is_administrator?
      administrators_dashboard_path
    else
    	root_path
    end
  end
end
