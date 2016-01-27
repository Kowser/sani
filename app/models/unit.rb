class Unit < ActiveRecord::Base
	validates_presence_of :number, :occupancy
end
