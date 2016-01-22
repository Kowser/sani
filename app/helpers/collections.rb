module Collections
	STATE = [
	  'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
	  'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
	  'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
	  'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
	  'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY',
	  'DC'
	]

	BG_STYLES = {
	  'Past Due' => 'danger',
	  'Paid' => 'success'
	}
	
	INQUIRY_OPTIONS = [
		'Maintenance Request',
		'Resident Request',
		'Question',
		'Other'
	]

	# converts true/false into Yes/No for human display
	BOOLEAN_WORDS = { true => 'Yes',	false => 'No'	}
end
