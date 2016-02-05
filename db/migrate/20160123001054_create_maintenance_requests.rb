class CreateMaintenanceRequests < ActiveRecord::Migration
  def change
    create_table :maintenance_requests do |t|
    	t.references :facility
    	t.string :location
    	t.text :description
    	t.string :priority
    	t.boolean :completed, default: false
      t.date :completed_date
      t.integer :created_by_id

      t.timestamps null: false
    end
  end
end
