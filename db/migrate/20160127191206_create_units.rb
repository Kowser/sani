class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
    	t.references :facility
    	t.string :number
    	t.string :occupancy, default: 'Undeclared'
    	t.boolean :active, default: true

    	t.timestamps null: false
    end
  end
end
