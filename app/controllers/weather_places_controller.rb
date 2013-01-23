class WeatherPlacesController < ApplicationController
  # GET /weather_places.json
  def index
    @weather_places = WeatherPlace.all

    @weather_places.each do |p|
      if @is_mock
        get_mock_weather_for(p)
      else
        get_weather_for(p)
      end
      puts "after loop #{p.current_temp_f}"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weather_places, methods: [:current_temp_f, :wind_speed] }
    end
  end

  # GET /weather_places/1.json
  def show
    @weather_place = WeatherPlace.find(params[:id])

    if @is_mock
      get_mock_weather_for(@weather_place)
    else
      get_weather_for(@weather_place)
    end

    respond_to do |format|
      format.json { render json: @weather_place, methods: [:current_temp_f, :wind_speed] }
    end
  end

  # POST /weather_places.json
  def create
    @weather_place = WeatherPlace.new(params[:weather_place])

    respond_to do |format|
      if @weather_place.save
        format.json { render json: @weather_place, status: :created, location: @weather_place }
      else
        format.json { render json: @weather_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weather_places/1.json
  def update
    @weather_place = WeatherPlace.find(params[:id])

    respond_to do |format|
      if @weather_place.update_attributes(params[:weather_place])
        format.json { head :no_content }
      else
        format.json { render json: @weather_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_places/1.json
  def destroy
    @weather_place = WeatherPlace.find(params[:id])
    @weather_place.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  protected
    def get_weather_for(p)
      w_api = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
      data = nil

      if p.state && p.city
        data = w_api.conditions_for(URI::encode(p.state), URI::encode(p.city))
        p.zipcode = "#{p.city}, #{p.state}".to_zip.first
      elsif p.zipcode
        data = w_api.conditions_for(p.zipcode)
        p.city = p.zipcode.to_region(:city => true)
        p.state = p.zipcode.to_region(:state => true)
      end

      if data != nil
        observation = data['current_observation']
        if observation != nil
          p.current_temp_f = observation['temp_f']
          p.wind_speed = observation['wind_mph']
          puts "Silly temp: #{p.current_temp_f}"
        end
      end

      p
    end

    def get_mock_weather_for(p)
      p.current_temp_f = rand(120) + (rand(2) == 0 ? rand().round(1) : 0)
      p.wind_speed = rand(30) + (rand(2) == 0 ? rand().round(1) : 0)
      p
    end

    def check_if_mock
      if ENV['MOCK_WEATHER']
        @is_mock = true
      end
    end
end
