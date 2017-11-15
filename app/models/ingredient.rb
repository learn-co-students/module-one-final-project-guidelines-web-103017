class Ingredient < ActiveRecord::Base
  has_many :beeringredients
  has_many :beers, through: :beeringredients
end