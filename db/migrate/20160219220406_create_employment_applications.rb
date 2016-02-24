class CreateEmploymentApplications < ActiveRecord::Migration
  def change
    create_table :employment_applications do |t|
      t.boolean :active, default: false
      t.text :notes

  		t.boolean :over_18
  		t.boolean :any_shift
  		t.string :any_shift_text
  		t.boolean :overtime
  		t.boolean :eligible_us
  		t.boolean :accomodations
  		t.text :accomodations_text
  		t.boolean :convictions
  		t.text :convictions_text
  		t.json :skills
  		t.string :name
  		t.string :address
  		t.string :phone
  	  t.string :email
  		t.text :other_information
  		t.boolean :certify
  	  t.string :location

      t.timestamps null: false
    end
  end
end