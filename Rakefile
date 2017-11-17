require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  Pry.start
end

namespace :populate do
  desc 'populate breweries table'
  task :breweries do
    DbSeed.seed_breweries
  end

  desc 'populate beers table'
  task :beers do
    DbSeed.seed_beers
  end

  desc 'populate ingredients table'
  task :ingredients do
    DbSeed.seed_ingredients
  end

  desc 'populate beer_ingredients table'
  task :beeringredients do
    DbSeed.seed_beeringredients
  end

end
