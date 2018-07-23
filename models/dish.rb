class Dish < ActiveRecord::Base
  has_many :comments # add extra methods
  belongs_to  :user # they add extra methods
  has_many :likes # add likes method 
end

