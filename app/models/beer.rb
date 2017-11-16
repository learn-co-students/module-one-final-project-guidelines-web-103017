class Beer < ActiveRecord::Base
  has_many :userbeers
  has_many :users, through: :userbeers
  has_many :beer_ingredients
  has_many :ingredients, through: :beer_ingredients

  def print_beer_info 
    puts "Name: #{self.name}"
    puts "Style: #{self.style}"
    puts "ABV: #{self.abv}"
    puts "Rating: #{self.rating}"
    puts "Organic? #{self.isorganic}"
    puts "Description: #{self.description}
    ~~~ "
  end
end