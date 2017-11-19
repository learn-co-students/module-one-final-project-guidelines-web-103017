require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  # ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

namespace :populate do
  desc 'populate breweries table with all API data'
  task :breweries do
    DbSeed.seed_breweries
  end

  desc 'populate breweries table with sample API data for n pages'
  task :breweries_sample do
    ARGV.each {|a| task a.to_sym do; end}
    DbSeed.seed_breweries_sample(ARGV[1].to_i)
  end

  desc 'populate beers table with data'
  task :beers do
    DbSeed.seed_beers
  end

  desc 'populate ingredients table with data'
  task :ingredients do
    DbSeed.seed_ingredients
  end

  desc 'populate beer_ingredients table'
  task :beer_ingredients do
    DbSeed.seed_beeringredients
  end

  desc 'populate beer_users table with random sample data'
  task :user_beers do
    ARGV.each {|a| task a.to_sym do; end}
    DbSeed.seed_user_beer(ARGV[1].to_i)
  end

end
