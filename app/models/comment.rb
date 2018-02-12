class Comment < ApplicationRecord
  belongs_to :post, touch: true

  validates :content, presence: true, length: { maximum: 210 }
end
