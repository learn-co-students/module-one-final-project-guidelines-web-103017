require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger.level = 1
# ActiveRecord::Base.logger = nil

# Logger::INFO

require_all 'app'
require_all 'lib'
