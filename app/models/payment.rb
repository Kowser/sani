class Payment < ActiveRecord::Base
	validates_presence_of :amount, :date, :resident
	before_create :record_payment
	belongs_to :resident
	belongs_to :invoice

	def record_payment
		if self.date.blank?
			self.date = Date.today
		end
	end
end
