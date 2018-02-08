class Post < ApplicationRecord
  has_attached_file :avatar, styles: { small: "150x150>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  paginates_per 10
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true,
                     length: { minimum: 1 }
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
