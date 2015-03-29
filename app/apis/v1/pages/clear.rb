class V1::Pages::Clear < Sliver::Rails::Action
  def self.guards
    [V1::Guards::AuthenticationGuard]
  end

  def self.processors
    [Sliver::Rails::Processors::JSONProcessor]
  end

  def call
    site.pages.each &:destroy

    response.body = {'status' => 'OK'}
  end

  def site
    @site ||= Site.find_by :name => path_params['site']
  end
end
