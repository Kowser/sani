class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.references :resident
    	t.decimal	   :total_due
      t.decimal    :balance_due
    	t.boolean    :paid, default: false
    	t.string     :number
    	t.date       :due_date
      t.text       :notes

    	t.timestamps null: false
    end
  end
end
