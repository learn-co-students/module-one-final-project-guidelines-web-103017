require 'json'
#require 'rest-client'

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
		#[gin, vodka, water]
		recipe_hash = {}
		ingredients.each do |x|
			recipes = RestClient.get('http://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{x}')
			parser = JSON.parse(recipes)
			recipe_hash[x] = parser
		end

		#recipe_hash{"gin" => #results, }
		z = 2
		recipe_perm = [] 
		while z != ingredients.length do
			recipe_perm << ingredients.permutation(z).to_a.map!{|x| x.sort}.uniq
			z += 1
		end
		recipe_perm = recipe_perm.flatten(1)

		





		
		#1. take each ingredient and query API DB
		#2. Return recipes that include that overlap


	end
end
