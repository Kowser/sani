class Resident < ActiveRecord::Base
	validates_presence_of :first_name, :last_name, :contact_first_name, :contact_last_name, :unit_id

	def name
		first_name + ' ' + last_name
	end

	def contact_name
		contact_first_name + ' ' + contact_last_name
	end
end