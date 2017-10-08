# frozen_string_literal: true

class V1::Pages::Update < Sliver::Rails::Action
  def self.guards
    [V1::Guards::AuthenticationGuard]
  end

  def self.processors
    [Sliver::Rails::Processors::JSONProcessor]
  end

  def call
    page                = site.pages.find_by_path page_params[:path]
    page.attributes     = page_params
    page.deactivated_at = nil

    response.body       = page_params

    response.body[:errors] = page.errors.full_messages unless page.save
  end

  def site
    @site ||= Site.find_by :name => path_params["site"]
  end

  private

  def page_params
    params.fetch(:page, {}).permit :name, :path, :content
  end
end
