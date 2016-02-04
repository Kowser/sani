class CreateJoinTableInvoicesPayments < ActiveRecord::Migration
  def change
    create_join_table :invoices, :payments do |t|
      t.index [:invoice_id, :payment_id]
      t.index [:payment_id, :invoice_id]

      t.timestamps
    end
  end
end
