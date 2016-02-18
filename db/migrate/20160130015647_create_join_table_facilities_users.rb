class CreateJoinTableFacilitiesUsers < ActiveRecord::Migration
  def change
    create_table :facilities_users do |t|
    	t.references :facility
    	t.references :user
      t.index [:facility_id, :user_id]
      t.index [:user_id, :facility_id]

      t.timestamps
    end
  end
end
