WeatherWidget::Application.routes.draw do
  resources :weather_places, :only => [:index, :show, :create, :update, :destroy]

  match 'weathers/forecast/:state/:city' => 'weather#forecast'

  match 'weathers/conditions/:state/:city' => 'weather#conditions'

  match 'weathers/:id' => 'weather#show'

  match 'weathers' => 'weather#index'

  root :to => 'weather#index'
end
