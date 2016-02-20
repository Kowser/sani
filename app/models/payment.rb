class Payment < ActiveRecord::Base
	current_month = 'receive_date >= ?', Date.today.at_beginning_of_month
	scope :undeposited, -> {where(deposited: false).where(current_month).pluck(:amount).inject(:+) || 0}
	scope :deposited, -> {where(deposited: true).where(current_month).pluck(:amount).inject(:+) || 0}

	before_validation :set_receive_date, on: :create, if: -> { receive_date.blank? }

	validates_presence_of :amount, :receive_date, :resident, :method
	# validates_presence_of :deposit_date, if: -> { deposited }

	belongs_to :resident
	has_and_belongs_to_many :invoices

	def set_receive_date
		self.receive_date = Date.today
	end
end
