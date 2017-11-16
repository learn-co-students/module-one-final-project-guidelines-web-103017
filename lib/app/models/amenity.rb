class Amenity < ActiveRecord::Base
  has_many :waterbody_amenities
  has_many :waterbodies, through: :waterbody_amenities
  has_many :counties, through: :waterbodies
end
