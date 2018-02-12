class Comment < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :user

  validates :content, presence: true, length: { maximum: 210 }
end
