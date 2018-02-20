class Post < ApplicationRecord
  has_attached_file :picture, styles: { normal: "150x150>", thumb: "50x50#" }, default_url: "/images/:style/missing.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  paginates_per 7
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true,
                     length: {
                               maximum: 750
                             }
  validates :latitude, :longitude,  presence: true

  geocoded_by :ip_address
  before_validation :geocode

  def ip_address
    "2620:0:2250:101c:1cfd:8a4f:162a:48eb"
  end
end
