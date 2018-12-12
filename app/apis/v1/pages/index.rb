# frozen_string_literal: true

class V1::Pages::Index < Sliver::Rails::Action
  HEADERS = {
    "Access-Control-Allow-Origin"   => "*",
    "Access-Control-Request-Method" => "GET"
  }.freeze

  def self.processors
    [Sliver::Rails::Processors::JSONProcessor]
  end

  def call
    response.headers = HEADERS.dup
    response.body    = paginated_results
  rescue ActiveRecord::RecordNotFound
    response.status = 404
    response.body   = {:error => "Site does not exist"}
  end

  private

  def error
    return nil unless error?

    "Site is not active. Please log in to check your account status."
  end

  def error?
    !site.accessible?
  end

  def page
    params.fetch("page", 1).to_i
  end

  def page_to_hash(page)
    {
      :name => page.name,
      :path => page.path
    }
  end

  def page_count
    error? ? 0 : pages.page_count
  end

  def pages
    return [] if error?

    @pages ||= site.pages.search query,
      :with     => {:deactivated_at => 0},
      :page     => page,
      :per_page => per_page
  end

  def paginated_results
    {
      :results  => pages.collect { |page| page_to_hash(page) },
      :page     => page,
      :per_page => per_page,
      :pages    => page_count,
      :total    => total_count,
      :error    => error
    }
  end

  def per_page
    params.fetch("per_page", 20).to_i
  end

  def query
    ThinkingSphinx::Query.escape(params["query"] || "")
  end

  def site
    @site ||= Site.find_by! :name => path_params["site"]
  end

  def total_count
    error? ? 0 : pages.total_count
  end
end
