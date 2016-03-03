ThinkingSphinx::Index.define :page, :with => :real_time do
  indexes name, content

  has site_id,        :type => :integer
  has deactivated_at, :type => :timestamp
end
