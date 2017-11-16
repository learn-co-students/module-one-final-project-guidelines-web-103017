require_all 'lib'

class CLI

  def self.welcome_list_choices
    puts("Hey Fish Head, we have alllll the fish in New York State. What can I get you? /n
    (Input the number corresponding to the information you would like.) /n")
  end

  def self.choices
    puts("1 - Tell me all the species of fish available in a NY body of water /n
    2 - Tell me all the species of fish available in a NY county /n
    3 - Tell me all the New York counties with a specific species of fish /n
    4 - Tell me all the waterbodies in a New York county /n
    5 - Exit /n")
  end

  def self.regreet
    puts("Hey there! Quick reminder of your options /n")
  end

  # #Paul original
  # def give_em_what_they_want(characteristic_name, to_know, type)
  #   puts("Which #{characteristic_name} would you like to see #{to_know} for?")
  #   input_name = gets.chomp.downcase
  #   if !type.find_by(name: input_name)
  #     puts("Hmmmm... Sorry, we don't have info on that #{characteristic_name}")
  #   else
  #     output = type.find_by(name: input_name).to_know.collect{|x|x[:name]}.to_sentence
  #     puts("You can find #{output} in #{input_name}")
  #   end
  # end
  #
  # def self.give_em_what_they_want(characteristic_name, to_know)
  #   puts("Which #{characteristic_name} would you like to see #{to_know} for?")
  #   input_name = gets.chomp.downcase
  #   if !characteristic_name.find_by(name: input_name)
  #     puts("Hmmmm... Sorry, we don't have info on that #{characteristic_name}")
  #   else
  #     output = characteristic_name.find_by(name: input_name).to_know.collect{|x|x[:name]}.to_sentence
  #     puts("You can find #{output} in #{input_name}")
  #   end
  # end

  # these don't work - 2nd arg is a method and you cant pass a method as an argument
  # I think that's the error anyway
  def self.input_1
    puts("Which bady of water would you like to see fish for?")
    input_name = gets.chomp.downcase
    if !Waterbody.find_by(name: input_name)
      puts("Hmmmm... Sorry, we don't have info on that body of water")
    else
      output = Waterbody.find_by(name: input_name).fish.collect{|x|x[:name]}.to_sentence
      puts("You can find #{output} in #{input_name}")
    end
  end

  def self.input_2
    give_em_what_they_want(Fish, counties)
  end

  def self.input_3
    give_em_what_they_want(County, fishes)
  end

  def self.input_4
    give_em_what_they_want(Waterbody, counties)
  end

  def self.invalid_input
    puts "Your input is invalid"
  end



  def self.command(input)
    if input == 1
      input_1
    elsif input == 2
      input_2
    elsif input == 3
      input_3
    elsif input == 4
      input_4
    elsif input != 5
      invalid_input
    end

  end


  def self.run
    #entry point list commands neeed to implement project
    welcome_list_choices
    choices
    input = gets.chomp.to_i
    while input != 5 && input != "exit"
      #binding.pry
      command(input)
      regreet
      choices
      input = gets.chomp.to_i
    end
    puts "Goodbye!"
  end



#   command = gets.chomp
#
#   def run
#     puts("Hey Fish Head, we have alllll the fish in New York State. What can I get you? /n
#       (Input the number corresponding to the information you would like.) /n
#         1 - Tell me all the species of fish available in a NY body of water /n
#         2 - Tell me all the species of fish available in a NY county /n
#         3 - Tell me all the New York counties with a specific species of fish /n
#         4 - Tell me all the waterbodies in a New York county /n
#         5 - Exit /n")
#     command = gets.chomp
#     until command == "5" || "exit"
#       command = gets.chomp
#       if command == "1"
#         puts("Which body of water would you like to know fish for?")
#         waterbody = gets.chomp.downcase
#         if !Waterbody.find_by(name: waterbody)
#           puts("Hmmmm... Sorry, we don't have info on that body of water")
#         else
#         fish = Waterbody.find_by(name: waterbody).fish.collect{|x|x[:name]}.to_sentence
#         puts("You can find #{fish} in #{waterbody}")
#         end
#     elsif command == "2"
#       puts("Which county would you like to know fish for?")
#       county = gets.chomp.downcase
#       if !County.find_by(name: county)
#         puts("Hmmmm... Sorry, we don't have info on that county")
#       else
#       fish = County.find_by(name: county).fish.collect{|x|x[:name]}.to_sentence
#       puts("You can find #{fish} in #{county} county")
#       end
#     elsif command == "3"
#       puts("Which county would you like to know fish for?")
#       county = gets.chomp.downcase
#       if !County.find_by(name: county)
#         puts("Hmmmm... Sorry, we don't have info on that county")
#       else
#       fish = County.find_by(name: county).fish.collect{|x|x[:name]}.to_sentence
#       puts("You can find #{fish} in #{county} county")
#       end
#       elsif command == "exit"
#         exit_jukebox
#       else
#         puts("That command is not valid. Please enter a different command:")
#       end
#     end
#
end
