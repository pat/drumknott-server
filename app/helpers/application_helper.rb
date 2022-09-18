# frozen_string_literal: true

module ApplicationHelper
  def external_javascript_version
    Rails.public_path.join("VERSION").read.strip
  end

  def require_credit_card?(site)
    site.new_record? && current_user.stripe_customer_id.blank?
  end
end
