class AddSentAtToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :sent_at, :datetime
  end
end
