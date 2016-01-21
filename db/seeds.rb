def self.create_user (params={})
	User.create!(
		email: 									params[:email],
		first_name: 						params[:first_name],
		last_name: 							params[:last_name],
		phone:									params[:phone],
		role: 									params[:role],
		password:              'password',
		password_confirmation: 'password'
	)
end

# Resident User
create_user(email: 'Resident@example.com', first_name: 'Michal', last_name:  'Kaszubowski', phone: '503-560-0700', role: 'resident')
create_user(email: 'admin@example.com', first_name: 'Breanna', last_name:  'Matson', phone: '503-345-6789', role: 'administrator')


