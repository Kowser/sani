class Unit < ActiveRecord::Base
	validates_presence_of :number, :occupancy, :facility_id
	belongs_to :facility
end
