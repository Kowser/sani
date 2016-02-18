class FacilitiesUser < ActiveRecord::Base
  belongs_to :facility
  belongs_to :user

  validates_uniqueness_of :facility_id, scope: :user_id, message: 'already has this staff member.'
end