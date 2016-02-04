class MaintenanceRequestsController < ApplicationController
	def index
		@maintenance_requests = MaintenanceRequests.all
	end

	def new

	end

	def create

	end
end

t.integer  "facility_id"
    t.string   "area"
    t.string   "description"
    t.string   "priority"
    t.boolean  "completed"