# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :user

  validates :stripe_invoice_id, :presence => true, :uniqueness => true
  validates :invoiced_at,       :presence => true

  scope :order_by_date, lambda { order :invoiced_at => :desc }

  def sent?
    sent_at.present?
  end

  def site
    line = data["lines"]["data"].first
    subscription_id = line["subscription"] || line["id"]

    @site ||= user.sites.find_by(:stripe_subscription_id => subscription_id)
  end
end
