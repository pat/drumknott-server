class V1::Pages::Index < Sliver::Rails::Action
  def self.processors
    [Sliver::Rails::Processors::JSONProcessor]
  end

  def call
    response.body = {
      :results  => pages.collect { |page| page_to_hash(page) },
      :page     => page,
      :per_page => per_page,
      :pages    => pages.page_count,
      :total    => pages.total_count
    }
  end

  private

  def page
    params.fetch('page', 1).to_i
  end

  def page_to_hash(page)
    {
      :name => page.name,
      :path => page.path
    }
  end

  def pages
    @pages ||= site.pages.search params['query'],
      :page => page
  end

  def per_page
    params.fetch('per_page', 20).to_i
  end

  def site
    @site ||= Site.find_by :name => path_params['site']
  end
end
