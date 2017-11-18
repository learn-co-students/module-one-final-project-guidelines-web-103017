class WaterbodyAmenity < ActiveRecord::Base
  belongs_to :waterbody
  belongs_to :amenity
end
