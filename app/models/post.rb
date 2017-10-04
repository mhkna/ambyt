class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  geocoded_by :ip
  validates :content, presence: true, length: { maximum: 210 }
  after_validation :geocode#, :if => :address_changed

  def coordinates
    [self.latitude, self.longitude]
  end
  # def distance_away(user_position)
  #   Geocoder::Calculations.distance_between(self.coordinates, user_position)
  # end
  #
  # def self.closest_ips(num_of_ips)
  #   #{{BLANK}}???.sort.first(num_of_ips)
  # end

  def view_area(distance)
    user_ip = request.remote_ip
    p user_ip
    view_area = Geocoder::Calculations.bounding_box(self.coordinates, distance)
    user_ip.within_bounding_box(view_area)
  end

end
