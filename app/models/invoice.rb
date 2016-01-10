class Invoice < ActiveRecord::Base
  belongs_to :user

  validates :user,              :presence => true
  validates :stripe_invoice_id, :presence => true, :uniqueness => true
  validates :invoiced_at,       :presence => true
end
