module Parameters
	RESIDENT_PARAMS = :first_name, :last_name, :contact_first_name, :contact_last_name, :phone, :email,
		:address, :city, :state, :zip, :move_in, :move_out, :rent, :room, :notes

	FACILITY_PARAMS = :name, :address, :city, :state, :zip, :phone, :fax,
		 { :units_attributes => [:id, :number, :occupancy, :active] }

	PAYMENT_PARAMS = :invoice_id, :amount, :receive_date, :resident_id, :method, :deposited, :deposit_date

	STAFF_PARAMS = :first_name, :last_name, :role, :email, :phone, :password, :password_confirmation

	MAINTENANCE_REQUEST_PARAMS = :location, :description, :priority, :completed, :completed_date

	INVOICE_PARAMS = :number, :due_date, :item, :total_due, :notes, :resident_id
end
