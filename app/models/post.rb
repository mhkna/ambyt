class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  geocoded_by :ip
  validates :content, presence: true, length: { maximum: 210 }
  after_validation :geocode#, :if => :address_changed

  def coordinates
    [self.latitude, self.longitude]
  end

  def in_ambyt?(user_position, range)
    distance = Geocoder::Calculations.distance_between(self.coordinates, user_position)
    true if distance < range
  end

  def self.display_in_ambyt(user_position, range)
    posts = Post.order(created_at: :desc)
    posts.select { |post| post.in_ambyt?(user_position, range) }
  end

  # def in_box?(distance)
  #   box = self.view_area_box(distance)
  #   return true if Post.within_bounding_box(box)
  #   return false
  # end
  #
  # def view_area_box(distance)
  #   Geocoder::Calculations.bounding_box(self.coordinates, distance)
  # end

end
