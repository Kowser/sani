class CreateJoinTableFacilitiesUsers < ActiveRecord::Migration
  def change
    create_join_table :facilities, :users do |t|
      t.index [:facility_id, :user_id]
      t.index [:user_id, :facility_id]

      t.integer :created_by_id
      t.timestamps
    end
  end
end
