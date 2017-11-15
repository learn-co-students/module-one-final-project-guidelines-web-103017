class CountyWaterbody < ActiveRecord::Base
  belongs_to :county
  belongs_to :waterbody
end
