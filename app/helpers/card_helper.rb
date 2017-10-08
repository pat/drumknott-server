# frozen_string_literal: true

module CardHelper
  def current_user_last4
    current_user.cache.fetch('card', {})['last4']
  end
end
