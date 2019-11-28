# frozen_string_literal: true

module ApplicationHelper
  def external_javascript_version
    File.read(Rails.root.join("public/VERSION")).strip
  end

  def require_credit_card?(site)
    site.new_record? && current_user.stripe_customer_id.blank?
  end
end
