class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.references :invoice
    	t.references :resident
    	t.decimal :amount
    	t.date :date
    	t.string :check_number

      t.timestamps null: false
    end
  end
end
