class Site < ActiveRecord::Base
  belongs_to :user
  has_many :pages, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :key,  :presence => true, :uniqueness => true
  validates :user, :presence => true

  before_validation :set_key, :on => :create

  scope :order_by_name, lambda { order :name => :asc }

  def accessible?
    status == 'active' || status == 'past_due'
  end

  def reset_key!
    update_attributes! :key => SecureRandom.hex(16)
  end

  private

  def set_key
    self.key ||= SecureRandom.hex 16
  end
end
