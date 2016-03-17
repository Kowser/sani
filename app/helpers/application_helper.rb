module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    'Sani' + (page_title.empty? ? '' : "#{' | ' + page_title}")
  end
end
