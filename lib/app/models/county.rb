class County < ActiveRecord::Base
  has_many :county_waterbodies
  has_many :waterbodies, through: :county_waterbodies
  has_many :fish, through: :waterbodies
  has_many :amenities, through: :waterbodies
end
