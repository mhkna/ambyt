class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 210 }
end
