class Site < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :key,  :presence => true, :uniqueness => true

  has_many :pages, :dependent => :destroy

  before_validation :set_key, :on => :create

  private

  def set_key
    self.key ||= SecureRandom.hex 16
  end
end
