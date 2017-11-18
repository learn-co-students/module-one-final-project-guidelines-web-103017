class Fish < ActiveRecord::Base
  has_many :waterbody_fishes
  has_many :waterbodies, through: :waterbody_fishes
  has_many :counties, through: :waterbodies
end
