def create_account
  create_user
  # sleep(5)
  system('clear')
  home_screen
end

private

def get_input
  gets.chomp
end


def create_user
  puts "Please enter your first and last name:"
  username = get_input

  puts "Please enter your city:"
  cityname = get_input
  puts "Please enter your state:"
  statename = get_input
  puts "Please enter your zipcode:"
  zipcode = get_input
  puts "Please enter your country:"
  country = get_input

  User.create(
    name: username,
    city: cityname,
    state: statename,
    zipcode: zipcode,
    country: country)

  puts "Thank you, #{username}! You can now return to the menu and browse beers and breweries!"
end