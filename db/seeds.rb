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

create_user(
	email: 'findme@example.com',
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
	phone: '503-123-4567',
	role: 'Staff'
)

facility.users << User.find(1,3,4,5)

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
