class MaintenanceRequest < ActiveRecord::Base
	# enum priority: { low: 1, medium: 3, high: 5 }
	priority_order = "CASE maintenance_requests.priority WHEN 'High' THEN 'a' WHEN 'Medium' THEN 'b' WHEN 'Low' THEN 'c' ELSE 'z' END ASC, id ASC"
	scope :completed_this_week, -> { where(completed: true).where('completed_date >  ?', Date.today - 7.days).order('completed_date DESC') }

	before_update :set_completed_date, if: -> { completed_changed? }

	validates_presence_of :priority, :location, :facility, :description, :requester
	validates :completed, inclusion: [true, false]
	belongs_to :facility
	belongs_to :requester, class_name: User

private
	def set_completed_date
		self.completed_date = if completed?
		  completed_date.blank? ? Date.today : completed_date
		else
			nil
		end
	end
end
