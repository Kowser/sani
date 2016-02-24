class CreateMaintenanceRequests < ActiveRecord::Migration
  def change
    create_table :maintenance_requests do |t|
    	t.references :facility
      t.integer :requester_id
      t.integer :priority
      t.boolean :completed, default: false, null: false
      t.date :completed_date
      t.string :location
      t.text :description

      t.timestamps null: false
    end
  end
end
