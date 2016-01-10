class My::SitesController < My::ApplicationController
  expose(:section) { 'sites' }
  expose(:sites)   { current_user.sites.order_by_name }
  expose(:site)    { site_in_context }

  def create
    if site.save
      SubscribeSiteWorker.perform_async site.id, params[:stripeToken]

      redirect_to my_sites_path
    else
      render :new
    end
  end

  def destroy
    site.update_attributes! :status => 'deleting'
    CancelSiteWorker.perform_async site.id

    redirect_to my_sites_path
  end

  private

  def site_in_context
    if params[:id].present?
      current_user.sites.find params[:id]
    else
      current_user.sites.new site_params
    end
  end

  def site_params
    params.fetch(:site, {}).permit(:name)
  end
end
