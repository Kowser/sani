class Unit < ActiveRecord::Base
	validates_presence_of :number, :occupancy, :facility
	belongs_to :facility
end
