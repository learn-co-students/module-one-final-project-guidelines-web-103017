def explore_beers
  beer_menu
end

# <-- MENUS & INPUT CONTROLS --> 
def beer_menu
  system('clear')
  puts "Welcome to Explore Beers!

        .~~~~.
        i====i_
        |cccc|_)
        |cccc|  
        `-==-'

 1. List Top Rated Beers
 2. Search for beers by keywords
 3. View our Beer of the Day!
 4. View Favorite Beers
 5. Return to Home Screen
 6. Exit the program

 Please enter a number:"
 beer_menu_input(get_input)
end

def beer_menu_input(input)
  case input
  when "1"
    top_rated_beers
  when "2"
    search_keyword_beers
  when "3"
    random_beer
  when "4"
    view_favorite_beers
  when "5"
    home_screen
  when "6"
    goodbye
  else
    puts throw_error
    beer_menu_input(get_input)
  end
end

def beer_dir_input(input)
  case input
  when "1"
    view_beer_ingredients
  when "2"
    save_beer
  when "3"
    beer_menu
  when "exit"
    puts "Goodbye!"
    exit
  else
    puts throw_error
    beer_dir_input(get_input)
  end
end

def beer_dir
  puts "If you would like to view ingredients of these beers, please enter 1.
  If you would like to rate and favorite any beers, please enter 2. <3
  To return to the beer menu, please enter 3.
  To exit the program, please type 'exit'.
  "
  beer_dir_input(get_input)
end

# <-- DB QUERIES --> 
def top_rated_beers
  puts "~~* Here are the top 10 beers as rated by our users! Enjoy! *~~
  "

  top_beers = UserBeer.select("id, beer_id, AVG(rating) as rating_avg").group(:beer_id).order("AVG(rating) desc").limit(10)

  top_beers.each do |user_beer|
    beer = Beer.find_by(id: user_beer.beer_id)
    puts "Rating #{user_beer.rating_avg}" 
    beer.print_beer_info
  end

  beer_dir
end

def search_keyword_beers
  puts "Please enter 3 keyword beer characteristics you would like to search by. For example, 'low malt flavor', 'herb and spice flavors', 'medium hop bitterness' are possible search queries."

  search_words = get_input.delete(",").split(" ")

  found_beers = Beer.where("description LIKE '%#{search_words[0]}%' OR description LIKE '%#{search_words[1]}%' OR description LIKE '%#{search_words[2]}%'").limit(3)

  found_beers.each {|beer| beer.print_beer_info}

  beer_dir 
end

def random_beer
  puts "Welcome to our Beer of the Day! Please wait as we find a new beer for you...
        ~  ~
      ( o )o)
     ( o )o )o)
    (o( ~~~~~~~~o
    ( )' ~~~~~~~'
   ( )|)       |-.
     o|        |-. \
     o|        |  \ \
      |        |   | |
     o|        |  / /
      |        |. ''
      |        |- '
      .========.   "

  sleep(2)
  random = rand((Beer.first.id.to_i)..(Beer.last.id.to_i))
  beer = Beer.all.select{|beer| beer.id == random}
  
  beer.first.print_beer_info

  beer_dir
end

def save_beer
  puts "Please enter the name of a beer you would like to save!"
  input = get_input
  if Beer.find_by(name: input) == nil
    puts "Sorry, we could not find your beer. Please check the name and try again."
    sleep(5)
    explore_beers
  else 
    beer_found = Beer.find_by(name: input)
    puts "Please rate this beer on a scale from 1-5"
    rating_input = get_input
    if !(1..5).include?(rating_input.to_i)
      puts "Please enter a valid number"
      save_beer
    else
      if UserBeer.find_by(beer_id: beer_found.id, user_id: @@user.id)
        puts "You have already rated this beer!"
        sleep(8)
        explore_beers
      else
        UserBeer.create(
          beer_id: beer_found.id,
          user_id: @@user.id,
          rating: rating_input.to_i
          )
        puts "Thank you for saving your beer! Taking you back to the menu for more options..."
        sleep(8)
        explore_beers
      end
    end
  end
end


def view_beer_ingredients
  puts "Please enter the name of the beer for which you would like to view the ingredients!"
  input = get_input

  if Beer.find_by(name: input) == nil
    puts "Sorry, we could not find your beer. Please check the name and try again."
    sleep(5)
    explore_beers
  else
    beer_found = Beer.find_by(name: input)
    beer_ingredients = beer_found.ingredients
    if beer_ingredients.any?
      beer_ingredients.each do |ingredient|
        puts ingredient["name"]
      end
      sleep(8)
      explore_beers
    else
      puts "This beer does not have any listed ingredients. Sorry!"
      sleep (5)
      explore_beers
    end
  end
end






















