class CLI
  def run
    #entry point list commands neeed to implement project
  end

  def give_em_what_they_want(characteristic_name, to_know, type)
    puts("Which #{characteristic_name} would you like to know #{to_know} for?")
    input_name = gets.chomp.downcase
    if !type.find_by(name: input_name)
      puts("Hmmmm... Sorry, we don't have info on that #{characteristic_name}")
    else
    output = type.find_by(name: input_name).to_know.collect{|x|x[:name]}.to_sentence
    puts("You can find #{output} in #{input_name}")
    end
  end

  Pry.start


  puts("Hey Fish Head, we have alllll the fish in New York State. What can I get you? /n
    (Input the number corresponding to the information you would like.) /n
      1 - Tell me all the species of fish available in a NY body of water /n
      2 - Tell me all the species of fish available in a NY county /n
      3 - Tell me all the New York counties with a specific species of fish /n
      4 - Tell me all the waterbodies in a New York county /n
      5 - Exit /n")

  command = gets.chomp

  def run
    puts("Hey Fish Head, we have alllll the fish in New York State. What can I get you? /n
      (Input the number corresponding to the information you would like.) /n
        1 - Tell me all the species of fish available in a NY body of water /n
        2 - Tell me all the species of fish available in a NY county /n
        3 - Tell me all the New York counties with a specific species of fish /n
        4 - Tell me all the waterbodies in a New York county /n
        5 - Exit /n")
    command = gets.chomp
    until command == "5" || "exit"
      command = gets.chomp
      if command == "1"
        puts("Which body of water would you like to know fish for?")
        waterbody = gets.chomp.downcase
        if !Waterbody.find_by(name: waterbody)
          puts("Hmmmm... Sorry, we don't have info on that body of water")
        else
        fish = Waterbody.find_by(name: waterbody).fish.collect{|x|x[:name]}.to_sentence
        puts("You can find #{fish} in #{waterbody}")
        end
    elsif command == "2"
      puts("Which county would you like to know fish for?")
      county = gets.chomp.downcase
      if !County.find_by(name: county)
        puts("Hmmmm... Sorry, we don't have info on that county")
      else
      fish = County.find_by(name: county).fish.collect{|x|x[:name]}.to_sentence
      puts("You can find #{fish} in #{county} county")
      end
    elsif command == "3"
      puts("Which county would you like to know fish for?")
      county = gets.chomp.downcase
      if !County.find_by(name: county)
        puts("Hmmmm... Sorry, we don't have info on that county")
      else
      fish = County.find_by(name: county).fish.collect{|x|x[:name]}.to_sentence
      puts("You can find #{fish} in #{county} county")
      end
      elsif command == "exit"
        exit_jukebox
      else
        puts("That command is not valid. Please enter a different command:")
      end
    end

end
