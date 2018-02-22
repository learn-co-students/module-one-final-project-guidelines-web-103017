def home_screen
  system('clear')
  puts home_menu
  home_input(get_input)
end


def home_menu
  "  o©ºº©oo©oº°©
    /           \
    |___________|____
    |            |____)
    |  B E E R   |  | |
    |            |  | |
    |   F O R    |  | |
    |            |  | |
    |   Y O U    |  | |
    |            |__|_|
    |            |____)
    |____________|
   (______________)

  1. Explore Beers
  2. Explore Breweries
  3. View Favorite Beers
  4. Exit the program

  Please enter a number:
  "
end

def home_input(input)
  case input
  when "1"
    explore_beers
  when "2"
    explore_breweries
  when "3"
    view_favorite_beers
  when "4"
    goodbye
  else
    throw_error
    home_input(get_input)
  end
end
