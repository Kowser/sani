class MaintenanceRequest < ActiveRecord::Base
	scope :completed, -> { where(completed: true).where('completed_date >  ?', Date.today - 7.days).order('completed_date DESC') }
	scope :incomplete, -> { where(completed: false).order('created_at ASC') }

	before_update :update_completed_date, if: -> { completed_changed? }

	validates_presence_of :priority, :location, :facility, :description, :created_by
	validates :completed, inclusion: [true, false]
	belongs_to :facility
	belongs_to :created_by, class_name: User

private
	def update_completed_date
		if completed?
		  completed_date = completed_date.blank? ? Date.today : completed_date
		else
			completed_date = nil
		end
	end
end
