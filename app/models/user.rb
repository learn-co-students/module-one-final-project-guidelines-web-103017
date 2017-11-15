require 'json'
require 'rest-client'

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

	def findrecipes
		ingredients = self.ingredients.map{|x| x.name}
		
		recipe_hash = {}
		ingredients.each do |x|
			recipes = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{x}")
			#binding.pry
			no_ingredients = (recipes.to_s == "")
			#binding.pry
			if no_ingredients == false
				parser = JSON.parse(recipes)
				recipe_hash[x] = parser
			end
		end


		#binding.pry

		#recipe_hash{"gin" => #results, }
		z = recipe_hash.keys.length
		recipe_perm = [] 
		until z < 2  do
			recipe_perm << recipe_hash.keys.permutation(z).to_a.map!{|x| x.sort}.uniq
			z -= 1
		end
		recipe_perm = recipe_perm.flatten(1)

		binding.pry
		# recipe_perm.each do |x|
		# 	recipe_hash







		
		#1. take each ingredient and query API DB
		#2. Return recipes that include that overlap


	end
end
