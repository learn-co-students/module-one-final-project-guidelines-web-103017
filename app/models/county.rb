class County < ActiveRecord::Base
  has_many :waterbodies, through: :counties_waterbodies
  has_many :fish, through: :waterbodies

end
