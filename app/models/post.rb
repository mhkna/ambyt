class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  # geocoded_by :ip
  validates :content, presence: true, length: { maximum: 210 }
  after_validation :geocode#, :if => :address_changed

  def coordinates
    [self.latitude, self.longitude]
  end

  # def distance_away(user_position)
  #   Geocoder::Calculations.distance_between(self.coordinates, user_position)
  # end

  def view_area_box(distance)
    Geocoder::Calculations.bounding_box(self.coordinates, distance)
  end

  def in_box?(distance)
    user_position = request.remote_ip
    p user_position
    box = self.view_area_box(distance)
    return true if user_position.within_bounding_box(box)
    return false
  end


end
