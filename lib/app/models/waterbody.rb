class Waterbody < ActiveRecord::Base
  has_many :waterbody_fishes
  has_many :counties, through: :counties_waterbodies
  has_many :fishes, through: :waterbody_fishes

end
