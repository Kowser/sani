# =====================================================================================
# USERS & FACILITIES
# =====================================================================================
def create_user(params)
	User.create!(params.merge(password: 'password', password_confirmation: 'password'))
end

# DEV OPS user
create_user(
	email: 'sys@example.com',
	first_name: 'Michal',
	last_name: 'Kaszubowski',
	phone: '360-333-6789',
	role: User.roles['devops']
)

# EXECUTIVE USER (Owner)
user = create_user(
	email: 'adam@peaksandvalleysnw.com',
	first_name: 'Adam',
	last_name: 'Reinke',
	phone: '360-333-6789',
	role: User.roles['partner']
)

# PRIMARY FACILITY - 15/16 residents, 1 unoccupied room
facility = Facility.new(
	name: 'All Comfort Residential Care',
	address: '9347 SW 35th Ave',
	city: 'Portland',
	state: 'OR',
	zip: '97225',
	phone: '503-987-1234',
	fax: '503-123-7890',
	owner_id: user.id
)
facility.units.build( number: 1, active: true)
facility.save!

# SECOND FACILITY - no residents, 1 unoccupied room
facility_2 = Facility.new(
	name: 'Hill House',
	address: '1325 SW Gibbs St.',
	city: 'Portland',
	state: 'OR',
	zip: '97239',
	phone: '503.274.0000',
	fax: '503.243.3427',
	owner_id: user.id
)
facility_2.units.build( number: 1, active: true)
facility_2.save!

# EXECUTIVE USER (Owner) - Unassigned to any facility
create_user(
	email: 'owner2@example.com',
	first_name: 'Steve',
	last_name: 'Martini',
	phone: '503-123-4567',
	role: User.roles['partner']
)

# ADMINISTRATOR USER (not a sys admin)
create_user(
	email: 'breanna@peaksandvalleysnw.com',
	first_name: 'Breanna',
	last_name: 'Matson',
	phone: '503-345-6789',
	role: User.roles['admin']
)

# MAINTENANCE USER
create_user(
	email: 'brian@peaksandvalleysnw.com',
	first_name: 'Brian',
	last_name: 'Carlson',
	phone: '503-123-4567',
	role: User.roles['staff']
)

# GENERAL STAFF USER
create_user(
	email: 'staff@peaksandvalleysnw.com',
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
	phone: '503-123-4567',
	role: User.roles['staff']
)

facility.users << User.all #excludes Sharleen below

# ADMINISTRATOR USER (not a sys admin)
facility_2.users <<  create_user(
	email: 'sharleen@peaksandvalleysnw.com',
	first_name: 'Sharleen',
	last_name: 'Moschella',
	phone: '503-345-6789',
	role: User.roles['admin']
)

facility_2.users << User.first #adds Michal Kaszubowski

# unassigned USER for test adding to facility(ies)
create_user(
	email: 'staff@example.com',
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
	phone: '503-123-4567',
	role: User.roles['staff']
)

# =====================================================================================
# MAINTENANCE REQUESTS
# =====================================================================================
[facility, facility_2].each do |fac|
	['Room 6', 'Boiler room, west corner', 'Upstairs hallway', 'Downstairs bathroom', 'Sliding door', 'Room 9 room window',
		'downstairs stair well', 'elevator', 'office', 'Room 3', 'kitchen'].each do |location|
		fac.maintenance_requests.create!(
			location: location,
			description: Faker::Lorem.sentences(rand(2..6)).join(', '),
			priority: [3, 1, 1, 1, 2, 2].sample,
			requester: fac.users.sample,
			completed: completed = [true, false].sample,
			completed_date: completed ? Faker::Date.between(7.days.ago, Date.today) : nil
		)
	end
end

# =====================================================================================
# RESIDENTS, INVOICES, PAYMENTS
# =====================================================================================
15.times do |i| 
	# +2 because empty room 1 exists from above
	unit = Unit.create!(facility_id: facility.id, number: i + 2,  active: true) 

	resident = Resident.create!(
		unit_id: unit.id,
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		contact_first_name: Faker::Name.first_name,
		contact_last_name: Faker::Name.last_name,
		phone: Faker::PhoneNumber.cell_phone,
		email: Faker::Internet.free_email,
		address: Faker::Address.street_address,
		city: Faker::Address.city,
		state: Faker::Address.state_abbr,
		zip: Faker::Address.zip_code,
		move_in: Faker::Date.between(365.days.ago, Date.today),
		rent: Faker::Number.between(35, 65) * 100
	)

# 	invoice = Invoice.create!(
# 		resident_id: resident.id,
# 		total_due: resident.rent,
# 		balance_due: resident.rent,
# 		number: "ACC-#{rand(1000..1999)}",
# 		due_date: Date.today.at_beginning_of_month,
# 		item: 'Monthly Rent & Residential Care Services',
# 		notes: 'Example of notes'
# 	)

# 	# PAST DUE invoice
# 	Invoice.create!(
# 		resident_id: resident.id,
# 		total_due: resident.rent,
# 		balance_due: resident.rent,
# 		number: "ACC-#{rand(1000..1999)}",
# 		due_date: (Date.today - 1.month).at_beginning_of_month,
# 		item: 'Monthly Rent & Residential Care Services',
# 		notes: 'Example of notes'
# 	) if rand(1..10) < 3 # seeds 20% past due rate

# 	# NEXT MONTH's invoice
# 	Invoice.create!(
# 		resident_id: resident.id,
# 		total_due: resident.rent,
# 		balance_due: resident.rent,
# 		number: "ACC-#{rand(1000..1999)}",
# 		due_date: (Date.today + 1.month).at_beginning_of_month,
# 		item: 'Monthly Rent & Residential Care Services',
# 		notes: 'Example of notes'
# 	) if [true, false].sample

	Payment.create!(
		resident_id: resident.id,
		amount: resident.rent,
		receive_date: Faker::Date.between(7.days.ago, Date.today),
		method: Collections::PAYMENT_METHODS.sample
	) if rand(1..10) < 9 # seeds 80% paid rate
end

# =====================================================================================
# EMPLOYMENT APPLICATIONS
# =====================================================================================
5.times do
	EmploymentApplication.create!(
		over_18: true,
		any_shift: temp = [true, false].sample,
		any_shift_text: temp ? '' : Faker::Lorem.sentences(rand(2..6)).join(', '),
		overtime: [true, false].sample,
		eligible_us: [true, true, false].sample,
		accomodations: temp = [true, false].sample,
		accomodations_text: temp ? '' : Faker::Lorem.sentences(rand(2..6)).join(', '),
		convictions: temp = [true, false].sample,
		convictions_text: !temp ? '' : Faker::Lorem.sentences(rand(2..6)).join(', '),
		skills: Collections::EMPLOYMENT_SKILLS.sample(rand(0..4)),
		name: Faker::Name.name,
		address: Faker::Address.street_address + ' ' + Faker::Address.city + ', ' + Faker::Address.state_abbr + ' ' + Faker::Address.zip,
		phone: Faker::PhoneNumber.phone_number,
		email: Faker::Internet.email,
		other_information: [true, false].sample ? Faker::Lorem.sentences(rand(2..6)).join(', ') : '',
		location: Collections::FACILITIES.sample,
		certify: true
	)
end
