class Unit < ActiveRecord::Base
	scope :occupied, -> { joins(:residents).where(residents: {active: true}) }

	validates_presence_of :number, :facility
	belongs_to :facility
	has_many :residents

	def name #simplifies formtastic select input
		number
	end
end
