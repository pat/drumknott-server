# frozen_string_literal: true

class V1::Pages::Clear < Sliver::Rails::Action
  def self.guards
    [V1::Guards::AuthenticationGuard]
  end

  def self.processors
    [Sliver::Rails::Processors::JSONProcessor]
  end

  def call
    # rubocop:disable Rails/SkipsModelValidations
    site.pages.update_all :deactivated_at => Time.current
    # rubocop:enable Rails/SkipsModelValidations

    response.body = {"status" => "OK"}
  end

  def site
    @site ||= Site.find_by :name => path_params["site"]
  end
end
