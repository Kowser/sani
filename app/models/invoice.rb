class Invoice < ActiveRecord::Base
	validates_presence_of :resident, :due_date, :total_due, :balance_due
	
	belongs_to :resident
	has_and_belongs_to_many :payments
end
