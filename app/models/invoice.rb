class Invoice < ActiveRecord::Base
	validates_presence_of :resident, :due_date, :total_due, :balance_due
	belongs_to :resident
	has_many :payments
end
