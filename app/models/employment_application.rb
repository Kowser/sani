class EmploymentApplication < ActiveRecord::Base	
	validates :name,
						:address,
						:phone,
						:email, presence: { message: 'Did you forget something?' }

	validates_inclusion_of :over_18,
						:any_shift,
						:overtime,
						:eligible_us,
						:accomodations,
						:convictions, :in => [true, false], message: 'Please select Yes or No.'

	validates_inclusion_of	:certify, :in => [true], message: 'You need to check this box.'

	# has_attached_file :resume
	# validates_attachment :resume, presence: { message: 'We really do want your resume.' },
	#   									 content_type: { content_type: 'application/pdf' }
	  									 # size: { in: 0..1500000 }
end
