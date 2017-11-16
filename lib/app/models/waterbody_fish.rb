class WaterbodyFish < ActiveRecord::Base
  belongs_to :fish
  belongs_to :waterbody
end
