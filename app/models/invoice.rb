class Invoice < ActiveRecord::Base
	validates_presence_of :resident, :amount_due, :status, :due_date
	belongs_to :resident
end