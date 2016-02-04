class Invoice < ActiveRecord::Base
	scope :upcoming_payments_this_month, -> { where(paid: false)
		.where('extract(month from due_date) = ?', Date.today.month) }
	scope :past_due_payments, -> { where(paid: false)
		.where('due_date < ?', Date.today.at_beginning_of_month) }

	validates_presence_of :resident, :due_date, :total_due, :balance_due
	
	belongs_to :resident
	has_and_belongs_to_many :payments
end
