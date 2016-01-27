class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
        t.references :unit
    	t.string :first_name
    	t.string :last_name
    	t.string :contact_first_name
    	t.string :contact_last_name
    	t.string :phone
    	t.string :email
    	t.string :address
    	t.string :city
    	t.string :state
    	t.string :zip
        t.date :move_in
        t.date :move_out
        t.decimal :rent, precision: 7, scale: 2

        t.timestamps null: false
    end
  end
end
