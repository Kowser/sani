class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.references :resident
    	t.decimal :amount
    	t.date :receive_date
    	t.date :deposit_date
      t.boolean :deposited
    	t.string :ref_number
    	t.string :method

      t.integer :received_by_id
      t.integer :deposited_by_id
      t.timestamps null: false
    end
  end
end
