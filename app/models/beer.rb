class Beer < ActiveRecord::Base
  has_many :userbeers
  has_many :users, through: :userbeers
  has_many :beeringredients
  has_many :ingredients, through: :beeringredients
end