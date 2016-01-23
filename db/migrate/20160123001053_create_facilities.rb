class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
    	t.string :name
    	t.string :street
    	t.string :city
    	t.string :state
    	t.integer :zip
    	t.string :phone
    	t.string :fax

      t.timestamps null: false
    end

    add_column :residents, :facility_id, :integer
  end
end
