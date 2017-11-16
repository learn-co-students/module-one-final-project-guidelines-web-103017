require_relative '../config/environment'

# printf '   *                              
#  (  `                             
#  )\))(   (      )      (          
# ((_)()\  )\  ( /(      )\  `  )   
# (_()((_)((_) )\())  _ ((_) /(/(   
# |  \/  | (_)((_)\  | | | |((_)_\  
# | |\/| | | |\ \ /  | |_| || '_ \) 
# |_|  |_| |_|/_\_\   \___/ | .__/  
#                           |_| '

class NewIn

	def welcome
		puts "Hello Welcome to MixUp. To Begin enter your name: "
		input = gets.chomp
		user = User.new(name: input.downcase)

		puts "Hello #{user.name} start by adding ingredients separated by comma:"
		input = gets.chomp
		array = input.downcase.split(', ').reject(&:empty?)

		user.add_ingredients(array)

		puts "You can now find recipes by your Ingredients with the command 'find'." 
		puts "To select a recipe type 'select' followed by your desired recipe name." 
		puts "To add MOAR Ingredients type 'MOAR'" 
		puts "And type 'Q' at any time to Quit" 

		while input != "q"
			input = gets.chomp
			input.downcase

			case input
				
			when "find"
				puts "This may take a moment. Stay sober...."
				user.findrecipes
				puts "To select a recipe type 'select' followed by your desired recipe name." 
				puts "To add MOAR Ingredients type 'MOAR'" 
				puts "And type 'Q' at any time to Quit"

			when "select"
				puts "Enter the recipe name: "
				userinput = gets.chomp
				userinput.to_i
				user.select_recipe(userinput)
				puts "You can now find recipes by your Ingredients with the command 'find'." 
				puts "To add MOAR Ingredients type 'MOAR'" 
				puts "And type 'Q' at any time to Quit"

			when "MOAR"
				
				puts "To Begin Add Ingredients separated by comma:"
				input = gets.chomp
				array = input.downcase.split(',').reject(&:empty?)

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

newu = NewIn.new
newu.welcome

	# puts "Welcome #{user}"
	# puts "To Quit just type 'Q'"
	# puts "To Begin Add Ingredients separated by comma:"
	# puts "For Example: Lemon, vodka, ChERy.,etc"
	# input = gets.chomp
	# if input == 'Q'
	# 	puts "Thank You"