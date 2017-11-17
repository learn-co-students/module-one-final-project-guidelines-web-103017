require 'json'
require 'rest-client'
require 'i18n'
require 'nokogiri'
require 'open-uri'


class User < ActiveRecord::Base
	has_many :useringredients
	has_many :ingredients, through: :useringredients
	has_many :userrecipes
	has_many :recipes, through: :userrecipes
	
	# def initialize
	# 	@missing_ingredients = 2
	# 	all_cocktails = nil
	# end

	# def missing_ingredients
	# 	@missing_ingredients
	# end

	# def missing_ingredients=(missing_ingredients)
	# 	@missing_ingredients = missing_ingredients
	# end

	# def all_cocktails
	# 	@all_cocktails
	# end

	# def all_cocktails=(all_cocktails)
	# 	@all_cocktails = all_cocktails
	# end

	def add_ingredients(array) #Adds ingredients to user in DB in ingredient does not exist already
		array.each do |ingredient|
			ingredient.downcase
			new_ingredient = Ingredient.find_or_create_by(name: ingredient)
			new_ingredient.save
		 	self.ingredients << new_ingredient
		end
		puts "Ingredients Added!"
	end

	def findrecipes
		
		ingredients = self.ingredients.map{|x| x.name} #takes the Users ingredients and creates an array
		
		recipe_hash = {}

		ingredients.each do |ingredient| #iterates over users ingredients
			recipes = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{ingredient}")#queries API and finds all cocktails that have that ingredient 
			no_ingredients = (recipes.to_s == "")
			if no_ingredients == false
				parser = JSON.parse(recipes)
				recipe_hash[ingredient] = parser
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
			recipe_hash[ingredient] = recipe_hash[ingredient]['drinks'].map{|x| x['strDrink']} #retrieves the recipe names from the JSON response
		end

		all_cocktails = Hash.new{|hash,key| hash[key]=[]}

		recipe_hash.each do |ingredient,v| #this reverses the hash relationships to Recipe Name => Ingredients
			recipe_hash[ingredient].each do |recipe|
				recipe_name = I18n.transliterate(recipe)
				all_cocktails[recipe_name] << ingredient
			end
		end

		#binding.pry


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
		all_cocktails.each do |name, ingredients| #finds the cocktail ingredients by querying the API
			response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{name}")
			cocktail_ing = JSON.parse(response)
			ingredient = cocktail_ing['drinks'][0].map{|ids,ingredient| ingredient.downcase if ingredient && ids.include?("strIngredient")}.compact!
			ingredient.reject!(&:empty?)
			all_cocktails[name] << ingredient #adds to recipe table
			all_cocktails[name].flatten!.uniq! 
		end
	                 
		 all_cocktails = Hash[all_cocktails.sort_by do |k,v| #sorting our cocktail recipes by the amount of missing ingredients
		 	duplicate = v 
		     arr = duplicate - ingredients.to_a 
		     arr.length
		   end  
		 ] 

		 all_cocktails.each do |recipe_name,ingredients| #creates recipes in our recipe table
		 	recipe = Recipe.find_or_create_by(name: recipe_name)
		 	ingredients.each do |recipe_ingredient|
		 		recipe.ingredients << Ingredient.find_or_create_by(name: recipe_ingredient)
		 	end
		 	recipe.save
		 	self.recipes << recipe
		 end

		 missing_ingredients = all_cocktails
		 	
		 missing_ingredients = Hash[missing_ingredients.sort_by do |k,v|
		  	arr = v&ingredients.to_a
		  	arr.each{|el| v.delete(el)}
		    end  
		  ]

		all_cocktails.each do |k,v| #outputs the recipe name and the ingredient missing
			puts "#{k}"
			puts ""
			puts "#{v.length} ingredients missing"
			puts "------------------------------"
		end


	end

	def select_recipe(recipe_name)#find the recipe in the database

		response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{recipe_name}")
		details = JSON.parse(response)

		puts '	  .'
		puts '	  .'
		puts '	 . .'
		puts '	  ...'
		puts '	\~~~~~/'
		puts '	 \   /'
		puts '	  \ /'
		puts '    	   V'
		puts '	   |'
		puts '	   |'
		puts '	  ---'

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
		missing = self.ingredients.collect{|x| x.name}
		m_i = ingredients-missing
		puts "-------------------------"

		if m_i.length > 0
			puts "You appear to be missing: "
			puts "-------------------------"
			
			puts m_i

			puts "Would like to find these ingredients at Walmart®? Type in 'y' or 'yes' for yes. Type anything to continue otherwise."
			input = gets.chomp
			if input.downcase=='yes' || input.downcase=='y' 
			 	find_at_localmarket(m_i)
			end
		else
			puts "You have all the ingredients for this recipe! Enjoy!"
			"-------------------------"
		end

	end

	def find_at_localmarket(array) #takes missing cocktail ingredients plugs them into the WalMart API

		array.each do |ingredient|
			response = RestClient.get("http://api.walmartlabs.com/v1/search?apiKey=7vp7x9xjzp8fnb2smkhmhzhv&query=#{ingredient}")
			parsed = JSON.parse(response)
			if parsed && parsed['message'] != "Results not found!" || parsed['message'] == nil
				puts "We found #{parsed['items'].first['name']} at Walmart for $#{parsed['items'].first['salePrice']}"
				puts "-----------------------"
			else
				puts "We couldn't find #{ingredient}"
				puts "-----------------------"
			end
		end
	end

end