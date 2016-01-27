class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.references :resident
    	t.decimal	:amount_due
    	t.string :status
    	t.string :invoice_number
    	t.date :invoice_date # usually on the 1st of each month
    	t.date :invoice_due_date

    	t.timestamps null: false
    end
  end
end
