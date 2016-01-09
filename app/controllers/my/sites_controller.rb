class My::SitesController < My::ApplicationController
  expose(:sites) { current_user.sites.order_by_name }
  expose(:site)  { current_user.sites.new site_params }

  def create
    if site.save
      SubscribeSiteWorker.perform_async site.id, params[:stripeToken]

      redirect_to my_sites_path
    else
      render :new
    end
  end

  private

  def site_params
    params.fetch(:site, {}).permit(:name)
  end
end
