class Beer < ActiveRecord::Base
  has_many :userbeers
  has_many :users, through: :userbeers

end