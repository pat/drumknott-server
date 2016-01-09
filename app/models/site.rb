class Site < ActiveRecord::Base
  belongs_to :user
  has_many :pages, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :key,  :presence => true, :uniqueness => true
  validates :user, :presence => true

  before_validation :set_key, :on => :create

  private

  def set_key
    self.key ||= SecureRandom.hex 16
  end
end
