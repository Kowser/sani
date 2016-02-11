class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.references :resident
    	t.decimal	   :total_due, precision: 7, scale: 2
      t.decimal    :balance_due, precision: 7, scale: 2
    	t.boolean    :paid, default: false
    	t.string     :number
    	t.date       :due_date
      t.text       :notes
      t.text       :item, default: ''

    	t.timestamps null: false
    end
  end
end
