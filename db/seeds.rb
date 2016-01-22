# ADMINISTRATOR USER
User.create!(
	email: 								 'admin@example.com',
	first_name: 					 'Breanna',
	last_name:  					 'Matson',
	phone: 								 '503-345-6789',
	role: 								 'administrator',
	password:              'password',
	password_confirmation: 'password'
)

# RESIDENTs (no User login)
16.times do |i|
	Resident.create!(
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
		rent: Faker::Number.between(35, 60) * 100,
		room: i + 101
	)
end
