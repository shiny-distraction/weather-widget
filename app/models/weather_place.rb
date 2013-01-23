class WeatherPlace < ActiveRecord::Base
  attr_accessor :current_temp_f, :wind_speed

  attr_accessible :city, :country, :state, :zipcode, :current_temp_f, :wind_speed
end
