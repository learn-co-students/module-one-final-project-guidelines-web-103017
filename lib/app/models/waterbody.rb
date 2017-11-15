class Waterbody < ActiveRecord::Base
  has_many :waterbody_fishes
  has_many :county_waterbodies
  has_many :counties, through: :county_waterbodies
  has_many :fish, through: :waterbody_fishes

end
