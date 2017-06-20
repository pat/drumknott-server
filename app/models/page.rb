class Page < ApplicationRecord
  belongs_to :site

  validates :site, :presence => true
  validates :name, :presence => true
  validates :path, :presence => true, :uniqueness => {:scope => :site_id}

  after_save ThinkingSphinx::RealTime.callback_for(:page)

  scope :deactivated_long_ago, lambda {
    where 'deactivated_at IS NOT NULL AND deactivated_at < ?', 1.day.ago
  }

  def self.find_by_path(path)
    find_by(:path => path) || new(:path => path)
  end

  def deactivated?
    deactivated_at.present?
  end
end
