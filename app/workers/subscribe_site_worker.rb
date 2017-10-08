# frozen_string_literal: true

class SubscribeSiteWorker
  include Sidekiq::Worker

  def perform(site_id, token)
    Payments::Subscribe.call Site.find(site_id), token
  end
end
