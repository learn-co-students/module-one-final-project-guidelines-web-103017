class Waterbody < ActiveRecord::Base
  has_many :counties through :counties_waterbodies
  has_many :fish through :waterbodies_fish

end
