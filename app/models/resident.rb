class Resident < ActiveRecord::Base
	scope :rents, -> { pluck(:rent).inject(:+) || 0 } #total monthly rents for dashboard
	scope :order_by_name,-> { order('residents.first_name ASC', 'residents.last_name ASC')}
	scope :order_by_unit,-> { order('residents.unit ASC')}

	belongs_to :unit
	has_many :invoices
	has_many :payments
	accepts_nested_attributes_for :payments, reject_if: lambda { |payment| payment[:amount].blank? }

	validates_presence_of :first_name, :last_name, :contact_first_name, :contact_last_name, :unit_id
	
	def name
		first_name + ' ' + last_name
	end

	def contact_name
		contact_first_name + ' ' + contact_last_name
	end
end