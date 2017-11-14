class Recipe < ActiveRecord::Base
	has_many :recipeingredients
	has_many :ingredients, through: :recipeingredients
	has_many :userrecipes
	has_many :users, through: :userrecipes
end
