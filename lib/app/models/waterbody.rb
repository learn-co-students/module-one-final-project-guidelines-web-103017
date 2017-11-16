class Waterbody < ActiveRecord::Base
  has_many :waterbody_fishes
  has_many :county_waterbodies
  has_many :waterbody_amenities
  has_many :counties, through: :county_waterbodies
  has_many :fish, through: :waterbody_fishes
  has_many :amenities, through: :waterbody_amenities
end
