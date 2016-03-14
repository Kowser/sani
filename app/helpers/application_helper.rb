module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    'Sani' + (page_title.empty? ? '' : "#{' | ' + page_title}")
  end

	def humanize_boolean(value)
		value ? 'Yes' : 'No'
	end

	def humanize_json(fields)
		fields.try(:delete_if, &:empty?).try(:join, '<br>').try(:html_safe) || 'None Selected'
	end

	def link_to_add_unit(f)
	  fields = f.fields_for(:units, f.object.units.build, child_index: "UNIT-#{99999}") do |u|
	    render('units', u: u)
	  end
	  link_to 'Add Room', '#', id: 'add-unit', data: { id: "UNIT-#{99999}", fields: fields.gsub('\n', '') }, class: 'btn btn-default'
	end
end
