class Beeringredient < ActiveRecord::Base
  belongs_to :ingredients
  belongs_to :beers
end
