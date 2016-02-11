class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.references :resident
    	t.decimal :amount, precision: 7, scale: 2
    	t.date :receive_date
    	t.date :deposit_date
      t.boolean :deposited, default: false
    	t.string :ref_number
    	t.string :method

      t.timestamps null: false
    end
  end
end
