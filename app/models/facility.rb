class Facility < ActiveRecord::Base
	validates_presence_of :name, :address, :city, :state, :zip, :phone
	has_many :units, inverse_of: :facility
	accepts_nested_attributes_for :units
end
