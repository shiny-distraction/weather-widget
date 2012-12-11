class Weather
  attr_accessor :current_temp_f, :wind_speed, :id, :city, :state

  def to_s
    "#{id} / #{city}, #{state} - #{current_temp_f} degrees - #{wind_speed} wind speed"
  end
end
