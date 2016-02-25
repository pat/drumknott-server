class Page < ActiveRecord::Base
  belongs_to :site

  validates :site, :presence => true
  validates :name, :presence => true
  validates :path, :presence => true, :uniqueness => {:scope => :site_id}

  after_save ThinkingSphinx::RealTime.callback_for(:page)

  def self.find_by_path(path)
    find_by(:path => path) || new(:path => path)
  end

  def deactivated?
    deactivated_at.present?
  end
end
