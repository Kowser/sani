module SessionsHelper
# CONTROLLER HELPER METHODS -----------------------------------------
  # Logs in the given user.
  def login(user)
    session[:user_id] = user.id
  end

  # Logs out the current user.
  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Remembers a user for a 30 day session.
  def remember(user)
    user.remember
    cookies.signed[:user_id] = { value: user.id, expires: 30.days.from_now.utc }
    cookies[:remember_token] = { value: user.remember_token, expires: 30.days.from_now.utc }
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns true for users associated with multiple facilities, false otherwise.
  def facility_selector
    @selector ||= current_user.facilities.count > 1 if current_user
  end

  # Returns true if facility selector is set & true, false otherwise.
  def facility_selector?
    @selector.present?
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

# VIEW / CONTROLLER HELPER METHODS ----------------------------------
  # Returns the user corresponding to the remember token cookie or session.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        login(user)
        @current_user = user
      end
    end
  end

  # Returns a facility corresponding to the facility_id, or defaults to the first user's facility, if available.
  def current_facility
    current_facility ||= (current_user.facilities.find_by(id: params[:facility_id]) || current_user.facilities.first)
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    current_user.present?
  end

  # Determines if user's role is greater than or equal to the given role.
  def authorized?(role)
    current_user[:role] >= User.roles[role]
  end
end