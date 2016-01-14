class AddSentAtToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :sent_at, :datetime
  end
end
