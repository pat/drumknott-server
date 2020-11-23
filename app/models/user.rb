# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable

  has_many :sites,    :dependent => :destroy
  has_many :invoices, :dependent => :destroy

  validates :country, :presence => true
end
