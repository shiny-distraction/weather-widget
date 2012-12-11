class WeatherController < ApplicationController
  respond_to :json

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
