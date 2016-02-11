class Facility < ActiveRecord::Base
	validates_presence_of :name, :address, :city, :state, :zip, :phone, :units, :owner
	
	belongs_to :owner, class_name: User
	has_many :units, inverse_of: :facility
	has_many :residents, through: :units
	has_many :invoices, through: :residents
	has_many :payments, through: :residents
	has_many :maintenance_requests
	has_and_belongs_to_many :users
	
	accepts_nested_attributes_for :units
end
