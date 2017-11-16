require 'json'
require 'rest-client'


class User < ActiveRecord::Base
	has_many :useringredients
	has_many :ingredients, through: :useringredients
	has_many :userrecipes
	has_many :recipes, through: :userrecipes
	
	# def initialize
	# 	@missing_ingredients = 2
	# 	self.all_cocktails = nil
	# end

	def missing_ingredients
		@missing_ingredients
	end

	def missing_ingredients=(missing_ingredients)
		@missing_ingredients = missing_ingredients
	end

	def all_cocktails
		@all_cocktails
	end

	def all_cocktails=(all_cocktails)
		@all_cocktails = all_cocktails
	end

	def add_ingredients(array)
		array.each do |ingredient|
			ingredient.downcase
			new_ingredient = Ingredient.find_or_create_by(name: ingredient)
			new_ingredient.save
		 	self.ingredients << new_ingredient
		end
		puts "Ingredients Added!"
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

		self.all_cocktails = Hash.new{|hash,key| hash[key]=[]}

		recipe_hash.each do |ingredient,v|
			recipe_hash[ingredient].each do |recipe_id|
				self.all_cocktails[recipe_id] << ingredient
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
		self.all_cocktails.each do |id, ingredients|
			response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}")
			cocktail_ing = JSON.parse(response)
			ingredient = cocktail_ing['drinks'][0].map{|ids,ingredient| ingredient.downcase if ingredient && ids.include?("strIngredient")}.compact!
			ingredient.reject!(&:empty?)
			self.all_cocktails[id] << ingredient
			self.all_cocktails[id].flatten!.uniq!
			#binding.pry
		end
	                 
		 self.all_cocktails = Hash[self.all_cocktails.sort_by do |k,v|
		 	duplicate = v 
		     arr = duplicate - ingredients.to_a 
		     arr.length
		   end  
		 ] 

		 # self.missing_ingredients = Hash[self.all_cocktails.sort_by do |k,v|
		 # 	arr = v&ingredients.to_a
		 # 	arr.each{|el| v.delete(el)}
		 #   end  
		 # ]

		 self.all_cocktails.each do |recipe_id,ingredients|
		 	recipe = Recipe.find_or_create_by(name: recipe_id)
		 	ingredients.each do |recipe_ingredient|
		 		recipe.ingredients << Ingredient.find_or_create_by(name: recipe_ingredient)
		 	end
		 	recipe.save
		 	self.recipes << recipe
		 end

		self.all_cocktails
	end

	def select_recipe(recipe_id)

		response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{recipe_id}")
		details = JSON.parse(response)

		puts "Name: #{details['drinks'][0]['strDrink']} (#{details['drinks'][0]['strAlcoholic']})"

		ingredients = details['drinks'][0].map{|ids,ingredient| ingredient.downcase if ingredient && ids.include?("strIngredient")}.compact!
		ingredients.reject!(&:empty?)

		measurements = details['drinks'][0].map{|ids,ingredient| ingredient.downcase if ingredient && ids.include?("strMeasure")}.compact!
		measurements.reject!(&:empty?)

		ingredient_measure = Hash[ingredients.zip(measurements)]

		puts "Ingredients: "
		ingredient_measure.each{|k,v| puts k +' - ' +v}
		puts "Should be served in: #{details['drinks'][0]['strGlass']}"
		puts "Instuctions: #{details['drinks'][0]['strInstructions']}"
		puts "You appear to be missing: "
		puts self.missing_ingredients[recipe_id]
		# puts "Would like to find these ingredients at your Wal-mart®?"
		# input = gets.chomp
		# if input.downcase=='yes' || input.downcase=='y'
		# 	puts "We need your Location. Input you 5 digit ZIP-CODE: "
		# 	input = gets.chomp
		# 	input.to_i
		# 	while input < 5 || input > 5
		# 		puts "Incorrect :( ZIP-CODE please try again: "
		# 		input = gets.chomp
		# 		input.to_i
		# 	end
		# 	self.location = input
		# 	find_at_walmart(self.missing_ingredients[recipe_id])
		# end

	end

	# def find_at_walmart([array])
	# 	array.each do |ingredient|


	# 	end
	# end

end
