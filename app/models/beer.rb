class Beer < ActiveRecord::Base
  has_many :user_beers
  has_many :users, through: :user_beers
  has_many :beeringredients
  has_many :ingredients, through: :beeringredients
end
