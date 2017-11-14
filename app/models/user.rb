class User < ActiveRecord::Base
	has_many :useringredients
	has_many :ingredients, through: :useringredients
	has_many :userrecipes
	has_many :recipes, through: :userrecipes
end
