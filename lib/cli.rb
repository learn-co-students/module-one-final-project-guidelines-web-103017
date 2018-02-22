def introduction
"    .   *   ..  . *  *
*  * @()Ooc()*   o  .
    (Q@*0CG*O()  ___
   |\_________/|/ _ \
   |  |  |  |  | / | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | | | |
   |  |  |  |  | \_| |
   |  |  |  |  |\___/
   |\_|__|__|_/|
    \_________/"

end

def welcome
  "
        Hello and welcome to Beer Bud!

        What would you like to do today?

        1. Login to existing account
        2. Create a new account
        3. Exit program

        Please enter a number:
  "
end

def get_input
  gets.chomp
end

def welcome_input(input)
  case input
  when "1"
    system('clear')
    user_login
  when "2"
    system('clear')
    create_account
  when "3"
    goodbye
  else
    throw_error
    welcome_input(get_input)
  end
end

def throw_error
  puts "You have entered an invalid selection. Please try again."
end

def runner
  system 'clear'
  puts introduction
  puts welcome
  welcome_input(get_input)
end

def goodbye
  puts "Goodbye!"
  sleep(2)
  exit
end
