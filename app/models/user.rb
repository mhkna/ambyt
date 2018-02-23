class User < ApplicationRecord
  acts_as_voter
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments

  def ip_address
    '12.34.246.63'
  end
end
