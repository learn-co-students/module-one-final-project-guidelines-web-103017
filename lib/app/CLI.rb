require_all 'lib'

class CLI
  def self.small_fish
      puts <<-Art

                                         _J""-.
             .-""L_                     /o )   \ ,';
        ;`, /   ( o\                    \ ,'    ;  /
        \  ;    `, /                     "-.__.'"\_;
        ;_/"`.__.-"

        Art
  end

  def self.large_fish
      puts <<-Art

      ,-.           ,.---'''^\                  O
     {   \       ,__\,---'''''`-.,      O    O
      I   \    K`,'^           _  `'.     o
      \  ,.J..-'`          // (O)   ,,X,    o
      /  (_               ((   ~  ,;:''`  o
     /   ,.X'.,            \\      ':;;;:
    (_../      -._                  ,'`
                K.=,;.__ /^~/___..'`
                        /  /`
                        ~~~

        Art
  end


  def self.welcome_list_choices
    puts "Hey Fish Head, we have alllll the fish in New York State. What can I get you?"
    puts "Input the number corresponding to the information you would like."
    large_fish
  end

  def self.choices
    puts "1 - Tell me all the species of fish available in a NY body of water"
    puts "2 - Tell me all the species of fish available in a NY county"
    puts "3 - Tell me all the New York counties with a specific species of fish"
    puts "4 - Tell me all the bodies of water in a New York county"
    puts "5 - Exit"
  end

  def self.regreet
    puts small_fish
    puts "Hey there! Quick reminder of your options"
  end

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


  def self.input_1
    puts("Which body of water would you like to see fish for?")
    input_name = gets.chomp.downcase
    system 'clear'
    if !Waterbody.find_by(name: input_name)
      puts("Hmmmm... Sorry, we don't have info on that body of water")
    else
      output = Waterbody.find_by(name: input_name).fish.collect{|x|x[:name]}.to_sentence
      puts("You can find #{output.titleize} in #{input_name.titleize}")
    end
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
    elsif input != 5
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
    while input != 5 && input != "exit"
      #binding.pry
      command(input)
      regreet
      choices
      input = gets.chomp.to_i
      system 'clear'
    end
    system 'clear'
    puts small_fish
    puts "Goodbye!"
  end

end
