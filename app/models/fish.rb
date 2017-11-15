class Fish < ActiveRecord::Base
  has_many :waterbodies, through: :waterbodies_fish
  has_many :counties, through: :waterbodies

end
