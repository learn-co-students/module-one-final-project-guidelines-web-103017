class User < ActiveRecord::Base
  has_many :userbeers
  has_many :beers, through: :userbeers
end