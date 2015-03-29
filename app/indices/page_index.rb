ThinkingSphinx::Index.define :page, :with => :real_time do
  indexes name, content

  has site_id, :type => :integer
end
