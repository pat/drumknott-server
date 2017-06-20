class CreateInvoices < ActiveRecord::Migration[4.2]
  def change
    create_table :invoices do |t|
      t.integer  :user_id,           :null => false
      t.string   :stripe_invoice_id, :null => false
      t.datetime :invoiced_at,       :null => false
      t.json     :data,              :null => false, :default => {}
      t.timestamps                   :null => false
    end

    add_index :invoices, :user_id
    add_index :invoices, :stripe_invoice_id, :unique => true
    add_index :invoices, [:user_id, :invoiced_at],
      :order => {:invoiced_at => :desc}
  end
end
