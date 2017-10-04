class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  geocoded_by :ip
  validates :content, presence: true, length: { maximum: 210 }
  after_validation :geocode#, :if => :address_changed

  def coords
    [self.latitude, self.longitude]
  end

  def nearest_users(distance)
    view_area = Geocoder::Calculations.bounding_box(self.coords, distance)
    #User.within_bounding_box(view_area)
  end

end
