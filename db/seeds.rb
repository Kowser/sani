# EXECUTIVE USER (Owner)
User.create!(
	email: 								 'owner@example.com',
	first_name: 					 'Michal',
	last_name:  					 'Kaszubowski',
	phone: 								 '503-560-0700',
	role: 								 'executive',
	password:              'password',
	password_confirmation: 'password'
)


# ADMINISTRATOR USER (not a sys admin)
User.create!(
	email: 								 'admin@example.com',
	first_name: 					 'Breanna',
	last_name:  					 'Matson',
	phone: 								 '503-345-6789',
	role: 								 'administrator',
	password:              'password',
	password_confirmation: 'password'
)

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
		amount_due: resident.rent,
		status: 'Unpaid',
		invoice_number: 'ACC-100#{i}',
		invoice_date: Date.today,
		invoice_due_date: '01/01/2016'
	)

	Payment.create!(
		invoice_id: invoice.id,
		amount: invoice.amount_due,
		date: Faker::Date.between(7.days.ago, Date.today),
		check_number: rand(1000..2000)
	) if (1..10).to_a.sample < 9 # about 80% paid rate
end
