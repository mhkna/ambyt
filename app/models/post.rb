class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :content, presence: true,
                     length: { minimum: 2 }
  validates :latitude, :longitude, presence: true

  geocoded_by :ip_address
  before_validation :geocode

  def ip_address
    # if @ip == "127.0.0.1"
    "2620:0:2250:101c:1cfd:8a4f:162a:48eb"
    # else
    #   @ip
    # end
  end

  def in_ambyt?(user_position, range)
    distance = Geocoder::Calculations.distance_between(self.coordinates, user_position)
    true if distance < range
  end

  def self.display_in_ambyt(user_position, range)
    posts = Post.order(created_at: :desc)
    posts.select { |post| post.in_ambyt?(user_position, range) }
  end

end
