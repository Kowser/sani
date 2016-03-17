module DashboardHelper
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