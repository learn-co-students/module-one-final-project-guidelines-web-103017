def create_account
  puts "Please enter your first and last name:"
  username = get_input
  if user_exist(username)
    puts "Looks like you already have an account! Please log in from the main menu :)"
    sleep(3)
    runner
  else
    create_user(username)
    sleep(5)
    system('clear')
    home_screen
  end
end

private

def user_exist(full_name)
  !!User.find_by(name: full_name)
end

def create_user(username)
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

  @user = User.find_by(name: username)
  puts "Thank you, #{username}! We are now returning you to the menu so you can browse beers and breweries!"
end
