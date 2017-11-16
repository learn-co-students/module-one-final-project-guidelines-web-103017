class Beer < ActiveRecord::Base
  has_many :user_beers
  has_many :users, through: :user_beers
  has_many :beer_ingredients
  has_many :ingredients, through: :beer_ingredients

  def print_beer_info 
    puts "Name: #{self.name}"
    puts "Style: #{self.style}"
    puts "ABV: #{self.abv}"
    puts "Organic? #{self.isorganic}"
    puts "Description: #{self.description}
    ~~~ "
  end
end

