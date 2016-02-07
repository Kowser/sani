class Payment < ActiveRecord::Base
	before_create :record_payment
	validates_presence_of :amount, :receive_date, :resident, :received_by

	belongs_to :resident
	belongs_to :created_by, class_name: User
	belongs_to :received_by, class_name: User
	belongs_to :deposited_by, class_name: User
	has_and_belongs_to_many :invoices

	def record_payment
		self.date = Date.today if self.receive_date.blank?
	end
end
