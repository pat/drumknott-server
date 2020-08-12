# frozen_string_literal: true

class Page < ApplicationRecord
  belongs_to :site

  validates :name, :presence => true
  validates :path, :presence => true, :uniqueness => {:scope => :site_id}

  ThinkingSphinx::Callbacks.append(self, :behaviours => [:real_time])

  scope :deactivated_long_ago, lambda {
    where "deactivated_at IS NOT NULL AND deactivated_at < ?", 1.day.ago
  }

  def self.find_by_path(path)
    find_by(:path => path) || new(:path => path)
  end

  def deactivated?
    deactivated_at.present?
  end
end
