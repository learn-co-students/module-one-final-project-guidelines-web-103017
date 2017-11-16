require 'json'
require 'rest-client'

class User < ActiveRecord::Base
	has_many :useringredients
	has_many :ingredients, through: :useringredients
	has_many :userrecipes
	has_many :recipes, through: :userrecipes

	def add_ingredients(array)
		array.each do |ingredient|
			ingredient.downcase
			new_ingredient = Ingredient.find_or_create_by(name: ingredient)
			new_ingredient.save
		 	self.ingredients << new_ingredient
		end
	end

	def findrecipes
		
		ingredients = self.ingredients.map{|x| x.name}
		
		recipe_hash = {}
		ingredients.each do |x|
			recipes = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{x}")
			no_ingredients = (recipes.to_s == "")
			if no_ingredients == false
				parser = JSON.parse(recipes)
				recipe_hash[x] = parser
			end
		end

		# z = recipe_hash.keys.length
		# recipe_perm = [] 
		# until z < 2  do
		# 	recipe_perm << recipe_hash.keys.permutation(z).to_a.map!{|x| x.sort}.uniq
		# 	z -= 1
		# end
		# recipe_perm = recipe_perm.flatten(1)

		recipe_hash.keys.each do |ingredient|
			recipe_hash[ingredient] = recipe_hash[ingredient]['drinks'].map{|x| x['idDrink']}
		end

		all_cocktails = Hash.new{|hash,key| hash[key]=[]}

		recipe_hash.each do |ingredient,v|
			recipe_hash[ingredient].each do |recipe_id|
				all_cocktails[recipe_id] << ingredient
			end
		end


		#recipe_hash
		# binding.pry
		# recipes = {}
		# recipe_perm.each do |array|
		# 	arr = []  
		# 	array.each do |x|   
		# 		arr << recipe_hash[x]       
		# 	end  
		# 	hsh = Hash.new(0)  
		# 	arr.flatten.collect{|x| hsh[x] += 1}

		# 	recipes[array] = hsh.map{|k,v| 
		# 		if v == array.length 
		# 			k
		# 		end 
		# 	}
		# end 

		# recipes.each{|k,v| v.compact!}

		# recipes.each do |ingredients,recipe_names|
		all_cocktails.each do |id, ingredients|
			response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}")
			cocktail_ing = JSON.parse(response)
			ingredient = cocktail_ing['drinks'][0].map{|ids,ingredient| ingredient.downcase if ingredient && ids.include?("strIngredient")}.compact!
			ingredient.reject!(&:empty?)
			all_cocktails[id] << ingredient
			all_cocktails[id].flatten!.uniq!
			#binding.pry
		end

		                 
		 all_cocktails = Hash[all_cocktails.sort_by do |k,v|
		 	duplicate = v 
		     arr = duplicate - ingredients.to_a 
		     arr.length
		   end  
		 ] 

		 # missing_ingredients =Hash[all_cocktails.sort_by do |k,v|
		 # 	arr = v&ingredients.to_a
		 # 	arr.each{|el| v.delete(el)}
		 #   end  
		 # ]
		 #binding.pry

		 all_cocktails.each do |recipe_id,ingredients|
		 	recipe = Recipe.find_or_create_by(name: recipe_id)
		 	ingredients.each do |recipe_ingredient|
		 		recipe.ingredients << Ingredient.find_or_create_by(name: recipe_ingredient)
		 	end
		 	recipe.save
		 	self.recipes << recipe
		 end



	end



end
