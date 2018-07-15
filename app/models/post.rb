class Post < ApplicationRecord
  has_attached_file :picture, styles: { normal: "150x200>" }, default_url: "/images/:style/none.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  validates_attachment_size :picture, :less_than => 1.megabyte
  paginates_per 7
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true,
                     length: {
                               maximum: 750
                             }
  validates :latitude, :longitude, presence: true
  geocoded_by :ip_address

  def set_lat_lon(ip_address)
    results = Geocoder.search(ip_address)
    self.latitude = results.first.latitude
    self.longitude = results.first.longitude
  end

end
