class MaintenanceRequest < ActiveRecord::Base
	priority_order = "CASE maintenance_requests.priority WHEN 'High' THEN 'a' WHEN 'Medium' THEN 'b' WHEN 'Low' THEN 'c' ELSE 'z' END ASC, id ASC"
	scope :completed, -> { where(completed: true).where('completed_date >  ?', Date.today - 7.days).order('completed_date DESC') }
	scope :incomplete, -> { where(completed: false).order(priority_order) }
	# default_scope {order(priority_order)}

	before_update :update_completed_date, if: -> { completed_changed? }

	validates_presence_of :priority, :location, :facility, :description, :requester
	validates :completed, inclusion: [true, false]
	belongs_to :facility
	belongs_to :requester, class_name: User

private
	def update_completed_date
		completed_date = if completed?
		  completed_date.blank? ? Date.today : completed_date
		else
			''
		end
	end
end
