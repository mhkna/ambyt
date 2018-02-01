class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :post

  validates :content, presence: true, length: { maximum: 210 }
end
