class WeatherController < ApplicationController
  respond_to :json

  def index
    # For now, assume Austin, TX
    w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
    data = w_api.conditions_for('TX', 'Austin')
    @weather = Weather.new
    @weather.current_temp_f = data['current_observation']['temp_f']
    @weather.wind_speed = data['current_observation']['wind_mph']
    @weather.id = "1"
    puts @weather
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weather }
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
end
