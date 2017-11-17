require_relative '../config/environment'

puts '	(  `     	'                 
puts '	)\))(  (     )      (     '	  
puts '	((_)()\ )\ ( /(      )\ `  )  	'
puts '	(_()((_|(_))\())  _ ((_) /(/(  	 '
puts '	|  \/  |(_|(_)\  | | | | ((_)_\  	'
puts '	| |\/| || \ \ /  | |_| | | |_ \) 	'
puts '	|_|  |_||_/_\_\   \___/  | .__/  	'
puts '				 |_|    '

class Cli

	def welcome
		puts "Hello Welcome to MixUp. For new account type 'new' if you are returning type 'User'"
		input = gets.chomp
		
		if input.downcase == "new"
			puts "Enter your name: "
			name_input = gets.chomp
			puts "Create your pin: "
			pass_input = gets.chomp
			user = User.new(name: name_input, location: pass_input.to_i)
			user.save
			puts "Your User Id is: #{user.id}. You will need this to login in the future."
		elsif input.downcase == "user"
			puts "Enter your ID: "
			id_input = gets.chomp
			user = User.find_by(id: id_input.to_i)
			while user == nil
				puts "Invalid ID Try Again"
				id_input = gets.chomp
				user = User.find_by(id: id_input.to_i)
			end
			puts "Now enter your pin"
			pass_input = gets.chomp
			#binding.pry
			while user.location.to_i != pass_input.to_i
				puts "Invalid Password. Please try again"
				pass_input = gets.chomp
			end
		end



		puts "Hello #{user.name}"
	
		puts "You can now find recipes by your Ingredients with the command 'find'." 
		puts "---------------------------------------------------------------------"
		puts "To select a recipe type 'select' followed by your desired recipe name."
		puts "----------------------------------------------------------------------" 
		puts "To see your ingredients type 'list'" 
		puts "-----------------------------------"
		puts "To add more ingredients type 'add'" 
		puts "-----------------------------------"
		puts "And type 'Q' at any time to Quit" 

		# input = gets.chomp
		# input.downcase

		while input != "q"
			input = gets.chomp
			input.downcase

			case input
				
			when "find"
				puts "This may take a moment. Stay sober...."
				user.findrecipes
				puts "To select a recipe type 'select' followed by your desired recipe name." 
				puts "To add more Ingredients type 'add'" 
				puts "To see your current ingredient list type 'list'"
				puts "And type 'Q' at any time to Quit"

			when 'list'
				user.ingredients.each{|x| puts x.name}
				puts "To select a recipe type 'select' followed by your desired recipe name." 
				puts "To add more Ingredients type 'add'" 
				puts "To add more Ingredients type 'MOAR'" 
				puts "To see your current ingredient list type 'list'"
				puts "And type 'Q' at any time to Quit"

			when "select"
				puts "Enter the recipe name: "
				userinput = gets.chomp
				userinput.to_i
				user.select_recipe(userinput)
				puts "You can now find recipes by your Ingredients with the command 'find'." 
				puts "To add MOAR Ingredients type 'MOAR'" 
				puts "And type 'Q' at any time to Quit"

			when "add"
				
				puts "To Begin Add Ingredients separated by comma:"
				input = gets.chomp
				array = input.downcase.split(/\s+|,\s*/)
				array.reject!(&:empty?)
				user.add_ingredients(array)
				puts "You can now find recipes by your Ingredients with the command 'find'." 
				puts "To select a recipe type 'select' followed by your desired recipe name." 
				puts "And type 'Q' at any time to Quit" 
			else
				"Invalid input"
			end
		end
	end
end

runner = Cli.new
runner.welcome

	# puts "Welcome #{user}"
	# puts "To Quit just type 'Q'"
	# puts "To Begin Add Ingredients separated by comma:"
	# puts "For Example: Lemon, vodka, ChERy.,etc"
	# input = gets.chomp
	# if input == 'Q'
	# 	puts "Thank You"