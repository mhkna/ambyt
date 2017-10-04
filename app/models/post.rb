class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  geocoded_by :ip
  validates :content, presence: true, length: { maximum: 210 }
  after_validation :geocode#, :if => :address_changed

end
