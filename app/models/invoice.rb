class Invoice < ActiveRecord::Base
  belongs_to :user

  validates :user,              :presence => true
  validates :stripe_invoice_id, :presence => true, :uniqueness => true
  validates :invoiced_at,       :presence => true

  def site
    @site ||= user.sites.find_by(
      :stripe_subscription_id => data['lines']['data'].first['id']
    )
  end
end
