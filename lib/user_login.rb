## User is logging in to existing account
def user_login
  puts "Please enter your first and last name: i.e. Jane Doe"
  username = get_input
  if user_exist(username)
    @@user = User.find_by(name: username)
    puts "Welcome to your Account! Loading Home Menu"
    sleep(3)
    home_screen
  else
    puts "Looks like you don't have an account, please create account from main menu"
    sleep(3)
    runner
  end

end
