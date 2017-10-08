# frozen_string_literal: true

class RemoveDeactivatedPages
  def self.call
    new.call
  end

  def call
    Page.deactivated_long_ago.find_each(&:destroy)
  end
end
