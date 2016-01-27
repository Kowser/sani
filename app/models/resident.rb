class Resident < ActiveRecord::Base
	validates_presence_of :first_name, :last_name, :contact_first_name, :contact_last_name, :unit_id
	belongs_to :unit
	has_many :invoices

	def name
		first_name + ' ' + last_name
	end

	def contact_name
		contact_first_name + ' ' + contact_last_name
	end
end