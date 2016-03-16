module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title = nil)
    # 'Sani' + (page_title.empty? ? '' : "#{' | ' + page_title}")
    ['Sani', page_title].delete_if(&:nil?).join(' | ')
  end

  # Only displays links appropriate to the page.
  def landing_menu_links
  	[ link_to_unless_current('Home', root_path) {}, 
  		link_to_if(current_page?(root_path),'Pricing', '#pricing') {},
  		link_to_if(current_page?(root_path),'About Us', '#about-us') {},
  		link_to_if(current_page?(root_path), 'Contact Us', '#contact-us') {},
  		link_to_unless_current('Sign Up', sign_up_path) { link_to 'Sign In', root_path }
  	].delete_if(&:nil?).join(' | ').html_safe
  end

  # Converts true/false to Yes/No
	def humanize_boolean(value)
		value ? 'Yes' : 'No'
	end

	# Takes multi-select checkbox results and displays them as a block list
	def humanize_json(fields)
		fields.empty? ? 'None Selected' : fields.delete_if(&:empty?).join('<br>').try(:html_safe)
	end

	# adds a blank Unit field to the facility form
	def link_to_add_unit(f)
	  fields = f.fields_for(:units, f.object.units.build, child_index: "UNIT-#{99999}") do |u|
	    render('units', u: u)
	  end
	  link_to 'Add Unit', '#', id: 'add-unit', data: { id: "UNIT-#{99999}", fields: fields.gsub('\n', '') }, class: 'btn btn-default'
	end

end
