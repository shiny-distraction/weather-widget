class WeatherPlace < ActiveRecord::Base
  attr_accessible :city, :country, :state, :zipcode
end
