class Post < ApplicationRecord
  has_many :comments
  
  validates :content, presence: true, length: { maximum: 300 }
end
