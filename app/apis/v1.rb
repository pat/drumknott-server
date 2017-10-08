# frozen_string_literal: true

class V1 < Sliver::API
  def initialize
    super do |api|
      api.connect :get,  "/:site/pages",       V1::Pages::Index
      api.connect :put,  "/:site/pages",       V1::Pages::Update
      api.connect :post, "/:site/pages/clear", V1::Pages::Clear
    end
  end
end
