class CreateMaintenanceRequests < ActiveRecord::Migration
  def change
    create_table :maintenance_requests do |t|
    	t.references :facility
    	t.string :location
    	t.string :description
    	t.string :priority
    	t.boolean :completed

      t.timestamps null: false
    end
  end
end
