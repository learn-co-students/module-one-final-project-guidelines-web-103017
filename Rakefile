require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveREcord::Base.logger = Logger.new(STDOUT)
  Pry.start
end
