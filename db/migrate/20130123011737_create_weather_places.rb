class CreateWeatherPlaces < ActiveRecord::Migration
  def change
    create_table :weather_places do |t|
      t.string :state
      t.string :city
      t.string :country
      t.integer :zipcode

      t.timestamps
    end
  end
end
