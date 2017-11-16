class Ingredient < ActiveRecord::Base
  has_many :beer_ingredients
  has_many :beers, through: :beer_ingredients
end