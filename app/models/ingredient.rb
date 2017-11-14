class Ingredients < ActiveRecord::Base
	has_many :useringredients
	has_many :users, through: :useringredients
	has_many :recipeingredients
	has_many :recipes, through: :recipeingredients
end
