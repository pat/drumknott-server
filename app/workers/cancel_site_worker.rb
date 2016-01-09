class CancelSiteWorker
  include Sidekiq::Worker

  def perform(site_id)
    site = Site.find site_id

    Payments::Cancel.call site
    site.destroy
  end
end
