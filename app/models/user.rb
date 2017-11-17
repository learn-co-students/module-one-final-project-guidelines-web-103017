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
			recipe_hash[ingredient] = recipe_hash[ingredient]['drinks'].map{|x| x['strDrink']}
		end

		self.all_cocktails = Hash.new{|hash,key| hash[key]=[]}

		recipe_hash.each do |ingredient,v|
			recipe_hash[ingredient].each do |recipe|
				recipe_name = I18n.transliterate(recipe)
				self.all_cocktails[recipe_name] << ingredient
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
		self.all_cocktails.each do |id, ingredients|
			response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{id}")
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


		 self.all_cocktails.each do |recipe_id,ingredients|
		 	recipe = Recipe.find_or_create_by(name: recipe_id)
		 	ingredients.each do |recipe_ingredient|
		 		recipe.ingredients << Ingredient.find_or_create_by(name: recipe_ingredient)
		 	end
		 	recipe.save
		 	self.recipes << recipe
		 end

		 self.missing_ingredients = self.all_cocktails
		 	
		 self.missing_ingredients = Hash[self.missing_ingredients.sort_by do |k,v|
		  	arr = v&ingredients.to_a
		  	arr.each{|el| v.delete(el)}
		    end  
		  ]

		self.all_cocktails.each do |k,v|
			puts "#{k}"
			puts ""
			puts "#{v.length} ingredients missing"
			puts "------------------------------"
		end


	end

	def select_recipe(recipe_id)

		response = RestClient.get("http://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{recipe_id}")
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
		puts "You appear to be missing: "
		puts "-------------------------"
		#binding.pry
		missing = self.ingredients.collect{|x| x.name}
		m_i = ingredients-missing
		puts m_i

		puts "Would like to find these ingredients at Walmart®?"
		input = gets.chomp
		if input.downcase=='yes' || input.downcase=='y' 
		 	find_at_localmarket(m_i)
		end

	end

	def find_at_localmarket(array)

		array.each do |ingredient|
			response = RestClient.get("http://api.walmartlabs.com/v1/search?apiKey=7vp7x9xjzp8fnb2smkhmhzhv&query=#{ingredient}")
			parsed = JSON.parse(response)
			#binding.pry
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