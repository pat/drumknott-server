module ApplicationHelper
  def require_credit_card?(site)
    site.new_record? && current_user.stripe_customer_id.blank?
  end
end
