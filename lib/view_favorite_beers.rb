def view_favorite_beers
  beers = @@user.beers
  if beers.any?
    puts "Beer Name,     Rating"
    beers.each_with_index do |beer, index|
      puts "#{index+1}. #{beer.name}, #{UserBeer.find_by(user_id: @@user.id, beer_id: beer.id).rating}"
    end
    what_now
  else
    puts "You don't have any saved beers :("
    what_now
  end
end

def favorite_options
  "
  What would you like to do now?

  1. Return to Home Screen
  2. Exit
  "
end

def what_now
  puts favorite_options
  input = get_input
  case input
  when "1"
    home_screen
  when "2"
    goodbye
  else
    throw_error
    what_now
  end
end
