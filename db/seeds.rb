def create_user(params)
	User.create!(params.merge(password: 'password', password_confirmation: 'password'))
end

# EXECUTIVE USER (Owner)
create_user(
	email: 'owner@example.com',
	first_name: 'Adam',
	last_name: 'Reinke',
	phone: '360-333-6789',
	role: 'executive'
)

# ADMINISTRATOR USER (not a sys admin)
create_user(
	email: 'admin@example.com',
	first_name: 'Breanna',
	last_name: 'Matson',
	phone: '503-345-6789',
	role: 'administrator'
)

# MAINTENANCE USER
create_user(
	email: 'maintenance@example.com',
	first_name: 'Brian',
	last_name: 'Maintenance',
	phone: '503-123-4567',
	role: 'staff'
)

# GENERAL STAFF USER
create_user(
	email: 'staff@example.com',
	first_name: 'Shelly',
	last_name: 'Staffington',
	phone: '503-123-4567',
	role: 'staff'
)

# =================

facility = Facility.create!(
	name: 'All Comfort Residential Care',
	address: '9347 SW 35th Ave',
	city: 'Portland',
	state: 'OR',
	zip: '97225',
	phone: '503-987-1234',
	fax: '503-123-7890'
)

16.times do |i|
	unit = Unit.create!(
		facility_id: facility.id,
		number: i + 1,
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
		rent: Faker::Number.between(35, 60) * 100
	)

	invoice = Invoice.create!(
		resident_id: resident.id,
		total_due: resident.rent,
		balance_due: resident.rent,
		number: "ACC-#{rand(1000..1999)}",
		due_date: '01/02/2016'
	)

	Invoice.create!(
		resident_id: resident.id,
		total_due: resident.rent,
		balance_due: resident.rent,
		number: "ACC-#{rand(1000..1999)}",
		due_date: '01/01/2016'
	) if [true, false].sample

	Payment.create!(
		invoice_id: invoice.id,
		resident_id: resident.id,
		amount: invoice.balance_due,
		date: Faker::Date.between(7.days.ago, Date.today),
		check_number: rand(1000..2000)
	) if (1..10).to_a.sample < 9 # about 80% paid rate
end
