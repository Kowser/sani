class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.references :resident
    	t.decimal	:amount_due
    	t.string :status
    	t.string :number
    	t.date :due_date

    	t.timestamps null: false
    end
  end
end
