class Payment < ActiveRecord::Base
	validates_presence_of :amount, :date, :resident
	belongs_to :resident
	belongs_to :invoice
end
