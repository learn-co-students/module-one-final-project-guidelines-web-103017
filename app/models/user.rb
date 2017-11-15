class User < ActiveRecord::Base
	has_many :useringredients
	has_many :ingredients, through: :useringredients

	has_many :userrecipes
	has_many :recipes, through: :userrecipes

	def add_ingredients(array)
		array.each do |x| 
			ingredient = Ingredient.new(name: x)
			ingredient.save
			self.ingredients << ingredient
		end
	end
end
