class Invoice < ApplicationRecord
  belongs_to :user

  validates :stripe_invoice_id, :presence => true, :uniqueness => true
  validates :invoiced_at,       :presence => true

  scope :order_by_date, lambda { order :invoiced_at => :desc }

  def sent?
    sent_at.present?
  end

  def site
    @site ||= user.sites.find_by(
      :stripe_subscription_id => data['lines']['data'].first['id']
    )
  end
end
