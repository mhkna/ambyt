class Comment < ApplicationRecord
  belongs_to :post

  validates :content, presence: true, length: { maximum: 210 }
end
