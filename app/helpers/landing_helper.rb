module LandingHelper
  # Only displays links appropriate to the page.
  def landing_menu_links
  	[ link_to_unless_current('Home', root_path) {}, 
  		link_to_if(current_page?(root_path), 'Features', '#features') {},
  		link_to_if(current_page?(root_path), 'Pricing', '#pricing') {},
  		link_to_if(current_page?(root_path), 'About Us', '#about-us') {},
  		link_to_if(current_page?(root_path), 'Contact Us', '#contact-us') {},
  		link_to_if(current_page?(sign_in_path) || current_page?(root_path), 'Sign Up', sign_up_path ) {},
  		link_to_if(current_user, 'Sign Out', logout_path, method: :delete) do
  			link_to_unless(current_page?(sign_in_path), 'Sign In', sign_in_path) {}
  		end
  	].delete_if(&:blank?).join(' | ').html_safe
  end
end