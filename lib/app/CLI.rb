require_all 'lib'

class CLI

  def self.welcome_list_choices
    puts "Hey Fish Head, we have alllll the fish in New York State. What can I get you?"
    puts "Input the number corresponding to the information you would like."
    ASCII.large_fish
  end

  def self.choices
    puts "1 - Tell me all the species of fish available in a NY body of water"
    puts "2 - Tell me all the species of fish available in a NY county"
    puts "3 - Tell me all the New York counties with a specific species of fish"
    puts "4 - Tell me all the bodies of water in a New York county"
    puts "5 - Tell me all the bodies of water that have a specific amenity"
    puts "6 - Exit"
  end

  def self.regreet
    ASCII.small_fish
    puts "Hey there! Quick reminder of your options"
  end


  def self.input_1
    puts("Which body of water would you like to see fish for?")
    input_name = gets.chomp.downcase
    system 'clear'
    if !Waterbody.find_by(name: input_name)
      puts("Hmmmm... Sorry, we don't have info on that body of water")
    else
      amenities = Waterbody.find_by(name: input_name).amenities.collect{|x|x[:name]}.to_sentence
      output = Waterbody.find_by(name: input_name).fish.collect{|x|x[:name]}.to_sentence
      puts("You can find #{output.titleize} in #{input_name.titleize}")
      puts("In case you were wondering, #{input_name.titleize} has a #{amenities}.")
      if Waterbody.find_by(name: input_name).url
        puts("Would you like to visit the #{input_name.titleize} website? (yes or no)")
        yesno = gets.chomp.downcase
        if yesno == "yes"
          system("open", Waterbody.find_by(name: input_name).url)
        end
      end
    end
    system 'clear'
  end

  def self.input_2
    puts("Which county would you like to see fish for?")
    input_name = gets.chomp.downcase
    system 'clear'
    if !County.find_by(name: input_name)
      puts("Hmmmm... Sorry, we don't have info on that county")
    else
      output = County.find_by(name: input_name).fish.collect{|x|x[:name]}.to_sentence
      puts("You can find #{output.titleize} in #{input_name.titleize} County")
    end
  end

  def self.input_3
    puts("Which species of fish would you like to see counties for?")
    input_name = gets.chomp.downcase
    system 'clear'
    if !Fish.find_by(name: input_name)
      puts("Hmmmm... Sorry, we don't have info on that fish species")
    else
      output = Fish.find_by(name: input_name).counties.collect{|x|x[:name]}.to_sentence
      puts("#{output.titleize} counties have #{input_name.titleize}") #if one switch have to has and counties to county
    end
  end

  def self.input_4
    puts("Which county in New York would you like to see all the bodies of water for?")
    input_name = gets.chomp.downcase
    system 'clear'
    if !County.find_by(name: input_name)
      puts("Hmmmm... Sorry, we don't have info on that county")
    else
      output = County.find_by(name: input_name).waterbodies.collect{|x|x[:name]}.to_sentence
      puts("#{output.titleize} are in #{input_name.titleize} County")
    end
  end

  def self.input_5
    puts "What amenity would you like to search for?"
    puts "If you would like to search for more than one, please separate by commas."
    puts "Options include: boat rental, campsite, fishing pier, or marina"
    input_name = gets.chomp.downcase.split(",").collect{|x|x.strip.downcase}
    #system 'clear'
    inputs_as_objects = input_name.collect{|input| Amenity.find_by(name: input)}
    waterbody_objects = Waterbody.all.select do |x|
      (x.amenities & inputs_as_objects).compact.sort_by{|x| x.name} == inputs_as_objects.compact.sort_by{|x| x.name}
    end
    waterbody_objects.each do |waterbody|
      puts("#{waterbody.name.titleize} - #{waterbody.counties.collect{|x|x.name.titleize}.to_sentence}")
    end
  end


  def self.invalid_input
    system 'clear'
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
    elsif input == 5
      input_5
    elsif input != 6
      invalid_input
    end

  end


  def self.run
    #entry point list commands neeed to implement project
    system 'clear'
    welcome_list_choices
    choices
    input = gets.chomp.to_i
    system 'clear'
    while input != 6 && input != "exit"
      command(input)
      regreet
      choices
      input = gets.chomp.to_i
      system 'clear'
    end
    system 'clear'
    ASCII.small_fish
    puts "Goodbye!"
  end

end
