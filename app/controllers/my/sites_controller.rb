# frozen_string_literal: true

class My::SitesController < My::ApplicationController
  expose(:section) { "sites" }
  expose(:sites)   { current_user.sites.order_by_name }
  expose(:site)    { site_in_context }

  def create
    if site.save
      SubscribeSiteWorker.perform_async site.id, params[:stripe_token]

      redirect_to my_sites_path
    else
      render :new
    end
  end

  def update
    if site.update site_params
      redirect_to my_site_path(site), :notice => t(".success")
    else
      render :edit
    end
  end

  def destroy
    site.update! :status => "deleting"
    CancelSiteWorker.perform_async site.id

    redirect_to my_sites_path
  end

  def regenerate
    site.reset_key!

    redirect_to my_site_path(site), :notice => t(".success")
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
