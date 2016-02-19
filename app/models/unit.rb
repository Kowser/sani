class Unit < ActiveRecord::Base
	validates_presence_of :number, :occupancy, :facility
	belongs_to :facility
	has_many :residents

	def name #simplifies formtastic select input
		number
	end
end
