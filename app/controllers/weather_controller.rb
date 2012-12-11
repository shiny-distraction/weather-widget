require 'open-uri'

class WeatherController < ApplicationController
  respond_to :json

  def index
    @weathers = []

    [ ['TX', 'Austin'],
      ['CA', 'San Francisco'],
      ['IL', 'Chicago'],
      ['NY', 'New York City'] ].each do |value| 
      @weathers << get_weather_for(*value)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weathers }
    end
  end

  def forecast
    w_api = setup_call
    data = w_api.forecast_for(@state, @city)
    respond(data, 'forecast')
  end

  def conditions
    w_api = setup_call
    data = w_api.conditions_for(@state, @city)
    respond(data, 'current_observation')
  end

  protected
    def setup_call
      @state = URI::encode(params[:state])
      @city = URI::encode(params[:city])
      @query_param = params[:q]
      Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
    end

    def respond(data, element)
      if @query_param
        respond_with data[element][@query_param]
      else
        respond_with data[element]
      end
    end

    def get_weather_for(*args)
      w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
      data = nil

      weather = Weather.new
      if args.length == 2
        state, city = *args
        data = w_api.conditions_for(URI::encode(state), URI::encode(city))
        weather.state = state
        weather.city = city
      elsif args.length == 1
        zipcode, = *args
        data = w_api.conditions_for(zipcode)
        weather.id = zipcode
      end

      if data != nil
        observation = data['current_observation']
        if observation != nil
          weather.current_temp_f = observation['temp_f']
          weather.wind_speed = observation['wind_mph']
        end
      end

      weather
    end
end
