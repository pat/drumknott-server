# frozen_string_literal: true

class V1::Guards::AuthenticationGuard < Sliver::Hook
  def continue?
    site && site.key == request.env["HTTP_AUTHENTICATION"]
  end

  def respond
    response.status = 401
    response.body   = {"status" => "Unauthorized: Invalid Session"}
  end

  private

  delegate :site, :request, :to => :action
end
