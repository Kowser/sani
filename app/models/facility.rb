class Facility < ActiveRecord::Base
	validates_presence_of :name, :address, :city, :state, :zip, :phone
end