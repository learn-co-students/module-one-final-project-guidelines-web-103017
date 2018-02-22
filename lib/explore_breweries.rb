def explore_breweries
  system('clear')
  puts breweries_menu
  breweries_input(get_input)
end

private

def breweries_menu
"                                     ^!^
         _._._._._._._._._._._._._._._._._   ^
         | ___   ___    ___    ___   ___ |
     ^!^ ||_|_| |_|_|  |_|_|  |_|_| |_|_||
         |IIIII_IIIII__IIIII__IIIII_IIIII|      ^
         | ___   ___    ___    ___   ___ |
 )o(_    ||_|_| |_|_|  |_|_|  |_|_| |_|_||
/(|)\    |IIIII_IIIII__IIIII__IIIII_IIIII|
  H)o(_  | ___   ___    ___    ___   ___ |
  /(|)\  ||_|_| |_|_|  |_|_|  |_|_| |_|_||
  H H    |IIIII_IIIII__IIIII__IIIII_IIIII|    /)
  H H    | ___   ___   _____   ___   ___ | __/ ),
   ~ ^~^ ||_|_| |_|_|  o~|~o  |_|_| |_|_||  ~^~^
  . ' .'.|IIIII_IIIII__|_|_|__IIIII_IIIII|'^~^'.',

  1. Find Breweries by Zip Code
  2. Find Breweries by City
  3. Return to Home Screen
  4. Exit the program

  Please enter a number:"
end

def breweries_input(input)
  case input
  when "1"
    find_breweries_by_zip
  when "2"
    find_breweries_by_city
  when "3"
    home_screen
  when "4"
    goodbye
  else
    throw_error
    breweries_input(get_input)
  end
end

def find_breweries_by_zip
  system('clear')
  puts "Please enter your five digit Zip Code:"
  input = get_input
  case valid_input(input)
  when true
    breweries = Brewery.where("postalcode = ?", input.to_i).select(:id, :name, :address, :website).limit(5)

    if breweries.any?
      parse_breweries(breweries)
      zip_what_now
    else
      puts "Sorry, there are no breweries in your zip code, please try again."
      zip_what_now

    end

  else
    puts "Entered Zip Code was not a valid input"
    explore_breweries
  end

end

def find_breweries_by_city
  system('clear')
  puts "Please enter your city:"
  input = get_input

  breweries = Brewery.where("city = ?", input).select(:id, :name, :address, :website).limit(5)

  if breweries.any?
    parse_breweries(breweries)
    city_what_now
  else
    puts "There are no breweries in your city, try searching by another city"
    city_what_now
  end
end

def valid_input(input)
  !input.split(/^\d{5}/).any?
end

def zip_return_menu
  "
  1. Find Breweries by Zip Code
  2. Return to Explore Breweries
  3. Exit

  Please enter a number:
  "
end

def zip_what_now
  sleep(5)
  puts zip_return_menu
  input = get_input
  case input
  when "1"
    find_breweries_by_zip
  when "2"
    explore_breweries
  when "3"
    goodbye
  else
    throw_error
    zip_return_menu
  end
end

def city_return_menu
  "
  1. Find Breweries by City
  2. Return to Explore Breweries
  3. Exit

  Please enter a number:
  "
end

def city_what_now
  sleep(5)
  puts city_return_menu
  input = get_input
  case input
  when "1"
    find_breweries_by_city
  when "2"
    explore_breweries
  when "3"
    goodbye
  else
    throw_error
    city_return_menu
  end
end

def parse_breweries(breweries)
  puts "These are the closest breweries to you (at most 5):"
  breweries.each_with_index do |brewery,index|
    puts "#{index+1}. #{brewery.name}, #{brewery.address}, #{brewery.website}"
    if brewery.beers.any?
      puts "#{brewery.name} produces the following beers:"
      brewery.beers.each{|beer| puts "   #{beer.name}"}
    else
      puts "No Beers currently listed for #{brewery.name}"
    end
  end
end
