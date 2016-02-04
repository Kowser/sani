def create_user(params)
	User.create!(params.merge(password: 'password', password_confirmation: 'password'))
end

# EXECUTIVE USER (Owner)
user = create_user(
	email: 'owner@example.com',
	first_name: 'Adam',
	last_name: 'Reinke',
	phone: '360-333-6789',
	role: 'Executive'
)

facility = Facility.new(
	name: 'All Comfort Residential Care',
	address: '9347 SW 35th Ave',
	city: 'Portland',
	state: 'OR',
	zip: '97225',
	phone: '503-987-1234',
	fax: '503-123-7890',
	created_by_id: user.id
)

facility.units.build(
# UNOCCUPIED ROOM
	number: 1,
  occupancy: ['Shared', 'Private'].sample,
  active: true
).save

# SECOND FACILITY - no residents
facility_2 = Facility.new(
	name: 'Hill House',
	address: '1325 SW Gibbs St.',
	city: 'Portland',
	state: 'OR',
	zip: '97239',
	phone: '503.274.0000',
	fax: '503.243.3427',
	created_by_id: user.id
)

facility_2.units.build(
# UNOCCUPIED ROOM
	number: 1,
  occupancy: ['Shared', 'Private'].sample,
  active: true
).save

# EXECUTIVE USER (Owner) - Unassigned to any facility
create_user(
	email: 'owner2@example.com',
	first_name: 'Steve',
	last_name: 'Martini',
	phone: '503-123-4567',
	role: 'Executive'
)

# ADMINISTRATOR USER (not a sys admin)
create_user(
	email: 'admin@example.com',
	first_name: 'Breanna',
	last_name: 'Matson',
	phone: '503-345-6789',
	role: 'Administrator'
)

# MAINTENANCE USER
create_user(
	email: 'maintenance@example.com',
	first_name: 'Brian',
	last_name: 'Carlson',
	phone: '503-123-4567',
	role: 'Staff'
)

# GENERAL STAFF USER
create_user(
	email: 'staff@example.com',
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
	phone: '503-123-4567',
	role: 'Staff'
)


facility.users << User.all

# ADMINISTRATOR USER (not a sys admin)
create_user(
	email: 'admin_2@example.com',
	first_name: 'Sharleen',
	last_name: 'Moschella',
	phone: '503-345-6789',
	role: 'Administrator'
)

facility_2.users << User.first #adds ADAM
facility_2.users << User.last

# USER to be found and added to a facility
create_user(
	email: 'findme@example.com',
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
	phone: '503-123-4567',
	role: 'Staff'
)

# =================

15.times do |i|
	unit = Unit.create!(
		facility_id: facility.id,
		number: i + 2, # +2 because empty room is already 1
	  occupancy: ['Shared', 'Private'].sample,
	  active: true
	)

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

	invoice = Invoice.create!(
		resident_id: resident.id,
		total_due: resident.rent,
		balance_due: resident.rent,
		number: "ACC-#{rand(1000..1999)}",
		due_date: Date.today.at_beginning_of_month
	)

	# PAST DUE invoice
	Invoice.create!(
		resident_id: resident.id,
		total_due: resident.rent,
		balance_due: resident.rent,
		number: "ACC-#{rand(1000..1999)}",
		due_date: (Date.today - 1.month).at_beginning_of_month
	) if (1..10).to_a.sample < 3 # seeds 20% past due rate

	# NEXT MONTH's invoice
	Invoice.create!(
		resident_id: resident.id,
		total_due: resident.rent,
		balance_due: resident.rent,
		number: "ACC-#{rand(1000..1999)}",
		due_date: (Date.today + 1.month).at_beginning_of_month
	) if [true, false].sample

	invoice.payments << Payment.create!(
		resident_id: resident.id,
		amount: invoice.balance_due,
		receive_date: Faker::Date.between(7.days.ago, Date.today),
		ref_number: rand(1000..2000),
		method: Collections::PAYMENT_METHOD.sample
	) if (1..10).to_a.sample < 9 # seeds 80% paid rate
end
