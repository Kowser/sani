module Collections
	STATES = [
	  'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
	  'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
	  'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
	  'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
	  'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY',
	  'DC'
	]

	PAYMENT_METHODS = ['Check', 'Cash', 'Money Order', 'Cashier\'s Check', 'Other']
	
	INQUIRY_OPTIONS = [
		'Maintenance Request',
		'Resident Request',
		'Question',
		'Other'
	]

	EMPLOYMENT_SKILLS = ['Providing assistance with ADLs', 'Medication Administration', 'Working with residents who have dementia', 'Cooking', 'Other']
	
	PERMISSIONS = {
		3 => [['Staff', 'staff'], ['Administrator', 'admin']],
		5 => [['Staff', 'staff'], ['Administrator', 'admin'], ['Partner/Owner', 'partner']],
	}

	MAINTENANCE_PRIORITY = [ ['Low', 'low'], ['Medium', 'medium'], ['High', 'high'] ]
	LABEL_PRIORITY = { 'high' => 'danger','medium' => 'warning','low' => 'success' }

	FACILITIES = ['Any', 'All Comfort Residential Care', 'Barbur Vista', 'The Hill House', 'Hillside Care Manor']
end
