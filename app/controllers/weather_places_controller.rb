class WeatherPlacesController < ApplicationController
  # GET /weather_places.json
  def index
    @weather_places = WeatherPlace.all

    respond_to do |format|
      format.json { render json: @weather_places }
    end
  end

  # GET /weather_places/1.json
  def show
    @weather_place = WeatherPlace.find(params[:id])

    respond_to do |format|
      format.json { render json: @weather_place }
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
end
