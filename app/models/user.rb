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

		z = recipe_hash.keys.length
		recipe_perm = [] 
		until z < 2  do
			recipe_perm << recipe_hash.keys.permutation(z).to_a.map!{|x| x.sort}.uniq
			z -= 1
		end
		recipe_perm = recipe_perm.flatten(1)

		recipe_hash.keys.each do |ingredient|
			recipe_hash[ingredient] = recipe_hash[ingredient]['drinks'].map{|x| x['strDrink']}
		end

		#recipe_hash
		binding.pry
		recipes = {}
		recipe_perm.each do |array|
			arr = []  
			array.each do |x|   
				arr << recipe_hash[x]       
			end  
			hsh = Hash.new(0)  
			arr.flatten.collect{|x| hsh[x] += 1}

			recipes[array] = hsh.map{|k,v| 
				if v == array.length 
					k
				end 
			}
		end 

		recipes.each{|k,v| v.compact!}

		recipes.each do |ingredients,recipe_names|
			recipe_names.each do |recipe|
				response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{recipe}")
				cocktail_ing = JSON.parse(response)
				ingredient = cocktail_ing['drinks'][0].map{|k,v| v if k.include?("strIngredient")}.compact!.reject!(&:empty?)
				
				if ingredient && ingredient.length - ingredients.length >= 3 
					recipe_names.delete(recipe)
				end
			end
		end



	end

end
