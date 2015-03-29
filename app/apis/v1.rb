class V1 < Sliver::API
  def initialize
    super do |api|
      api.connect :get, '/:site/pages', V1::Pages::Index
      api.connect :put, '/:site/pages', V1::Pages::Update
    end
  end
end
